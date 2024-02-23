//
//  Expense.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 23.02.2024.
//

import Foundation

struct Expense: Identifiable, Hashable {
    let id = UUID()
    let day: Date
    let amount: Int
    let description: String
    
    init(day: Date, amount: Int, description: String) {
        self.day = day
        self.amount = amount
        self.description = description
    }
}
