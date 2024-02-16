//
//  VideoModel.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 27.10.2023.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: Int
    let name: String
    let video: String
}
