//
//  NetworkDataFetcher.swift
//  SingleResponsibilityPrinciple
//
//  Created by Mustafa Bekirov on 21.02.2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchFreeApps(urlString: String, completion: @escaping (AppGroup?) -> Void) {
        networkService.request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(AppGroup.self, from: data)
            completion(response)
        }
    }
    
    func fetchPaidApps(urlString: String, completion: @escaping (AppGroup?) -> Void) {
        networkService.request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(AppGroup.self, from: data)
            completion(response)
        }
    }
    
    func fetchCountry(urlString: String, completion: @escaping ([Country]?) -> Void) {
        networkService.request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode([Country].self, from: data)
            completion(response)
        }
    }
}
