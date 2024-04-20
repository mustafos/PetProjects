//
//  AsyncAwaitView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 17.04.2024.
//

import Foundation

private actor ServiceStore {
    func loadEmployees() async throws -> [Employee] {
        var employees = [Employee]()
        let (data, response) = try await URLSession.shared.data(from: Link.employees.url)
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        
        if statusCode == 429 {
            throw NetworkError.tooManyRequests
        }
        
        guard let decodedQuery = try? JSONDecoder().decode(Query.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        employees = decodedQuery.data
        
        return employees
    }
}

final class AsyncAwaitView: ObservableObject {
    @Published var employees = [Employee]()
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
            employees = try await store.loadEmployees()
        } catch {
            print("Catch: \(error)")
            errorMessage = warningMessage(error: error as! NetworkError)
            showError = true
        }
    }
}
