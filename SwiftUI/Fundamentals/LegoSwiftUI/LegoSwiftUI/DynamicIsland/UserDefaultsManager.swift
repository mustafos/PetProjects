//
//  UserDefaultsManager.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 13.03.2024.
//

import Foundation

struct UserDefaultsManager {
    static func saveNewActivity(id: String, 
                                arrivalTime: String,
                                phoneNumber: String,
                                restaurantName: String,
                                customerAddress: String) {
        let activity =
        [
            "id": id,
            "arrivalTime": arrivalTime,
            "phoneNumber": phoneNumber,
            "restaurantName": restaurantName,
            "customerAddress": customerAddress
        ]
        
        if var activities: [[String: Any]] = UserDefaults.standard.object(forKey: "live_activities") as? [[String: String]] {
            activities.append(activity)
            UserDefaults.standard.set(activities, forKey: "live_activities")
        } else {
            UserDefaults.standard.set([activity], forKey: "live_activities")
        }
    }
    
    static func fetchActivities() -> [FoodDeliveryAttributes.ContentState] {
        guard let activities: [[String: String]] = UserDefaults.standard.object(forKey: "live_activities") as? [[String: String]] else { return [] }
        return activities.compactMap ({
            FoodDeliveryAttributes.ContentState(arrivalTime: $0["arrivalTime"] ?? "", phoneNumber: $0["phoneNumber"] ?? "",
                                                restaurantName: $0["restaurantName"] ?? "", customerAddress: $0["customerAddress"] ?? "")
        })
    }
}
