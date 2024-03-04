//
//  ReadingData.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 08.02.2024.
//

import SwiftUI

struct ReadingData: Codable, Equatable, Identifiable {
    let url: URL?
    let title: String
    let creationDate: Date
    var hasFinishedReading: Bool
    var id: Date { return creationDate }
    
    static func example() -> ReadingData {
        ReadingData(url: URL(string: "https://habr.com/ru/companies/it-guide/articles/733272/"),
                    title: "Habr",
                    creationDate: Date(),
                    hasFinishedReading: false)
    }
}
