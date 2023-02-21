//
//  NetworkService.swift
//  SingleResponsibilityPrinciple
//
//  Created by Mustafa Bekirov on 12.02.2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.

import Foundation

class NetworkService {
    
    // building a data request by url
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
