//
//  DataFetcherService.swift
//  SingleResponsibilityPrinciple
//
//  Created by Mustafa Bekirov on 21.02.2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.

import Foundation

class DataFetcherService {
    
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchFreeApps(completion: @escaping (AppGroup?) -> Void) {
        let urlFreeApp = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/10/apps.json"
        dataFetcher.fetchGenericJSONData(urlString: urlFreeApp, response: completion)
    }
    
    func fetchPaidApps(completion: @escaping (AppGroup?) -> Void) {
        let urlPaidApp = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/10/apps.json"
        dataFetcher.fetchGenericJSONData(urlString: urlPaidApp, response: completion)
    }
    
    func fetchCountry(completion: @escaping ([Country]?) -> Void) {
        let urlString = "https://raw.githubusercontent.com/Softex-Group/task-mobile/master/test.json"
        dataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
}
