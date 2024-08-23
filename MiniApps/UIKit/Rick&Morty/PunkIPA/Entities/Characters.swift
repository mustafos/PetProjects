//
//  Characters.swift
//  PunkIPA
//

import Foundation

typealias Characters = [Character]

struct RickAndMorty: Decodable {
    let results: Characters
}

struct Character: Codable {
    let name, species, type: String
    let image: String
}
