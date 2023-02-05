//
//  APIManager.swift
//  SwiftAPI
//
//  Created by Mustafa Bekirov on 30.01.2023.
//

import Foundation

enum APIType {
    
    case login
    case getUsers
    case getPosts
    /*case getAlbums*/
    case getPhotos
    
    var baseURL: String {
    return "https://jsonplaceholder.typicode.com/"
    }
    
    var headers: [String: String] {
        switch self {
            case .login:
                return ["authToken": "12345"]
            default:
                return [:]
        }
    }
    
    var path: String {
        switch self {
            case .login: return "login"
            case .getUsers: return "users"
            case .getPosts: return "posts"
//            case .getAlbums: return "albums"
            case .getPhotos: return "photos"
        }
    }
    
    var request: URLRequest {
        var url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
            case .login:
                request.httpMethod = "POST"
                return request
            default:
                request.httpMethod = "GET"
                return request
        }
    }
}

class APIManager {
    
    static let shared = APIManager()
    
    func getUsers(completion: @escaping (Users) -> Void) {
        var request = APIType.getUsers.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let users = try? JSONDecoder().decode(Users.self, from: data) {
                completion(users)
            } else {
                completion([])
            }
        }
        task.resume()
    }
    
    func getPosts(completion: @escaping (Posts) -> Void) {
        var request = APIType.getPosts.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let photos = try? JSONDecoder().decode(Posts.self, from: data) {
                completion(photos)
            } else {
                completion([])
            }
        }
        task.resume()
    }
    
    func getPhotos(completion: @escaping (Photos) -> Void) {
        var request = APIType.getPhotos.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let photos = try? JSONDecoder().decode(Photos.self, from: data) {
                completion(photos)
            } else {
                completion([])
            }
        }
        task.resume()
    }
}

/**====================open api random joke====================**/
private func makeRequest() {
    var request = URLRequest(url: URL(string: "https://v2.jokeapi.dev/joke/Any")!)
    request.allHTTPHeaderFields = ["authToken": "nil"]
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data, let joke = try? JSONDecoder().decode(Joke.self, from: data) {
            print(joke.setup as Any)
        }
    }
    task.resume()
}
