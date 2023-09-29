//
//  Item.swift
//  MapsApp
//
//  Created by Mustafa Bekirov on 15.09.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
