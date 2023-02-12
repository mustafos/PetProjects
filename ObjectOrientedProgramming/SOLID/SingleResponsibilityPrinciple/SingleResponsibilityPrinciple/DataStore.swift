//
//  DataStore.swift
//  SingleResponsibilityPrinciple
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import Foundation

class DataStore {
    
    // storing data in the cache
    func saveNameInCache(name: String) {
        print("Your name: \(name) is saved")
    }
    
    // get data from cache
    func getNameFromCache() -> String {
        return "some name"
    }
}
