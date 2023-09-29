//
//  NetworkManager.swift
//  HTTPRequest
//
//  Created by Mustafa Bekirov on 08.02.2023.
//

import Foundation

enum ObtainPostsResult {
    case success(posts: [Post])
    case failure(error: Error)
}

class NetworkManager {
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func obtainPosts(completion: @escaping (ObtainPostsResult) -> Void) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            var result: ObtainPostsResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let strongSelf = self else {
                
                result = .success(posts: [])
                
                return
            }
            
            if error == nil, let parsData = data {
                
                guard let posts = try?
                        strongSelf.decoder.decode([Post].self, from: parsData) else {
                    
                    result = .success(posts: [])
                    return
                }
                
                result = .success(posts: posts)
            } else {
                result = .failure(error: error!)
            }
            
        }.resume()
    }
}
