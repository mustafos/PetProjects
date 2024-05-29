//
//  NetworkManager.swift
//  LazyLoadGallery
//
//  Created by Mustafa Bekirov on 28.05.2024.
//

import Foundation

enum NetworkError: Error {
    case noData
    case tooManyRequests
    case decodingError
}

private actor ServiceStore {
    private let userDefaultsKey = "cachedPosts"
    
    func loadPosts() async throws -> [Post] {
        let url = URL(string: "https://496.ams3.cdn.digitaloceanspaces.com/data/test.json")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }
        
        let statusCode = httpResponse.statusCode
        
        if statusCode == 429 {
            throw NetworkError.tooManyRequests
        }
        
        guard (200...299).contains(statusCode) else {
            throw NetworkError.noData
        }
        
        guard let posts = try? JSONDecoder().decode([Post].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        cachePosts(posts)
        return posts
    }
    
    private func cachePosts(_ posts: [Post]) {
        if let encoded = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func getCachedPosts() async -> [Post]? {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedPosts = try? JSONDecoder().decode([Post].self, from: savedData) {
            return decodedPosts
        }
        return nil
    }
}


final class NetworkManager: ObservableObject {
    @Published var posts = [Post]()
    @Published var inProgress = false
    @Published var showError = false
    @Published var errorMessage = ""
    
    private let store = ServiceStore()
    
    @MainActor func fetchAllEmployees() async {
        inProgress = true
        defer {
            inProgress = false
        }
        do {
            posts = try await store.loadPosts()
        } catch {
            if let cachedPosts = await store.getCachedPosts() {
                posts = cachedPosts
                errorMessage = "Loaded cached data due to error: \(error.localizedDescription)"
            } else {
                errorMessage = warningMessage(error: error as! NetworkError)
            }
            showError = true
        }
    }
    
    func retryFetch() {
        Task {
            await fetchAllEmployees()
        }
    }
    
    private func warningMessage(error: NetworkError) -> String {
        switch error {
        case .noData:
            return "No data available."
        case .tooManyRequests:
            return "Too many requests. Please try again later."
        case .decodingError:
            return "Failed to decode data."
        }
    }
}
