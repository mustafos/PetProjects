//
//  VolkswagenGolf.swift
//  Decorator
//
//  Created by Mustafa Bekirov on 16.02.2023.
//

import Foundation

class VolkswagenGolf: VolkswagenProtocol {
    func getTitle() -> String {
        return "VolkswagenGolf"
    }
    
    func getPrice() -> Double {
        return 10000
    }
}
