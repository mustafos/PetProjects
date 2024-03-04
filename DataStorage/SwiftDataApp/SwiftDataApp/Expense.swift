//
//  Expense.swift
//  SwiftDataApp
//
//  Created by Mustafa Bekirov on 05.11.2023.
//

import Foundation
import SwiftData

@Model
final class Expense {
    var name: String
    var timestamp: Date
    var value: Double
    
    init(name: String, timestamp: Date, value: Double) {
        self.name = name
        self.timestamp = timestamp
        self.value = value
    }
}
