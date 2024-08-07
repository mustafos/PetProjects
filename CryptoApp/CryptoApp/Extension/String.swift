//
//  String.swift
//  CryptoApp
//
//  Created by Mustafa Bekirov on 06.08.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
