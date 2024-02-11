//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by Mustafa Bekirov on 16.04.2023.
//

import Foundation

extension Double {
    
    func toString() -> String {
        return String(format: "%.1f", self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
}
