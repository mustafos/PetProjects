//
//  FoodDeliveryAttributes.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 13.03.2024.
//

import Foundation
import ActivityKit

struct FoodDeliveryAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var arrivalTime: String
        var phoneNumber: String
        var restaurantName: String
        var customerAddress: String
    }
}
