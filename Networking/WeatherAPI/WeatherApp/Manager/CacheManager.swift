//
//  CacheManager.swift
//  WeatherApp
//
//  Created by Mustafa Bekirov on 19.04.2023.
//

import Foundation

struct CacheManager {
    
    private let vault = UserDefaults.standard
    
    enum Key: String {
        case city
    }
    
    func cacheCity(cityName: String) {
        vault.set(cityName, forKey: Key.city.rawValue)
    }
    
    func getCachedCity() -> String? {
       return vault.value(forKey: Key.city.rawValue) as? String
    }
}
