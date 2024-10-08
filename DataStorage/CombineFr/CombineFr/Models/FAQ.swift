//
//  FAQ.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 05.04.2023.
//

import Foundation

struct FAQ: Decodable, Identifiable {
    var id: Int
    var question: String
    var answer: String
}
