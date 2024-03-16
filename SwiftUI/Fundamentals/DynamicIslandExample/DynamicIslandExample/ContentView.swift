//
//  ContentView.swift
//  DynamicIslandExample
//
//  Created by Mustafa Bekirov on 16.03.2024.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                do {
                    deleteAllActivities()
                    let id = try LiveActivityManager.startActivity(arrivalTime: "15 Mins", phoneNumber: "42076056712", restaurantName: "McDonald's", customerAddress: "42b Baker Street", remainingDistance: "50")
                    
                    UserDefaultsManager.saveNewActivity(id: id, arrivalTime: "15 Mins", phoneNumber: "42076056712", restaurantName: "McDonald's", customerAddress: "42b Baker Street", remainingDistance: "50")
                } catch {
                    print(error.localizedDescription)
                }
            } label: {
                Text("Place Order")
            }
        }
        .padding()
    }
    
    private func deleteAllActivities() {
        for item in UserDefaultsManager.fetchActivities() {
            
            if let activity = Activity<FoodDeliveryAttributes>.activities.first(where: {$0.contentState.phoneNumber == item.phoneNumber}) {
                Task {
                    await LiveActivityManager.endActivity(activity.id)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
