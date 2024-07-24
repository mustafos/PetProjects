//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Mustafa Bekirov on 24.07.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
