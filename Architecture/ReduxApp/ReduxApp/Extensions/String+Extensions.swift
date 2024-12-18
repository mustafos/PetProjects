//
//  String+Extensions.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 04.01.2025.
//

import Foundation

extension String {
    func urlEncode() -> String {
        self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? self
    }
    
    func toInt() -> Int {
        let ratingDouble = Double(self) ?? 0.0
        return Int(ratingDouble.rounded())
    }
}
