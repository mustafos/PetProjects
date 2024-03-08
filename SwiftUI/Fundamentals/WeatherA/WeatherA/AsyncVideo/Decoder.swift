//
//  Decoder.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 27.10.2023.
//

import Foundation

let videos: [Video] = Bundle.main.decode("video.json")
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        // 1. Locate the JSON file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // 2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in bundle.")
        }
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create a property for the decoded data
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        // 5. Return the ready-to use data
        return decodedData
    }
}

