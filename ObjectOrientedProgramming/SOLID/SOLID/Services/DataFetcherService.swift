//
//  DataFetcherService.swift
//  SOLID
//
//  Created by Mustafa Bekirov on 21.02.2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.

import Foundation

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    var localDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher(), localDataFetcher: DataFetcher = LocalDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
        self.localDataFetcher = localDataFetcher
    }
    
    func fetchFreeApps(completion: @escaping (AppGroup?) -> Void) {
        let urlFreeApp = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/10/apps.json"
        networkDataFetcher.fetchGenericJSONData(urlString: urlFreeApp, response: completion)
    }
    
    func fetchPaidApps(completion: @escaping (AppGroup?) -> Void) {
        let urlPaidApp = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/10/apps.json"
        networkDataFetcher.fetchGenericJSONData(urlString: urlPaidApp, response: completion)
    }
    
    func fetchCountry(completion: @escaping ([Country]?) -> Void) {
        let urlString = "https://raw.githubusercontent.com/Softex-Group/task-mobile/master/test.json"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
    func fetchLocalCountry(completion: @escaping ([Country]?) -> Void) {
        let localURLString = "usersAPI.txt"
        localDataFetcher.fetchGenericJSONData(urlString: localURLString, response: completion)
    }
}
