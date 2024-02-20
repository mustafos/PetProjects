//
//  Extension+String.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 20.02.2024.
//

import Foundation

extension String {
    public subscript(_ idx: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: idx)]
    }
}
