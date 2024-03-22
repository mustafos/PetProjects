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
            
            DynamicIslandButton()
            
            ScrollView(.vertical, showsIndicators: false) {
                let adPlacement: Int = 2
                
                VStack(spacing: 20) {
                    ForEach(1...8, id: \.self) { index in
                        CardView(index: index)
                        if index % adPlacement == 0 {
                            BannerAd(unitID: "ca-app-pub-4744463005672993/8422976347")
                        }
                    }
                }
                .padding()
            }
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Button {
                    
                } label: {
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
            }
            .overlay(
                Text("Chatty")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
            )
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
    
    @ViewBuilder
    func CardView(index: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            GeometryReader { proxy in
                let size = proxy.size
                Image("Post\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(15)
            }
            .frame(height: 250)
            
            HStack(spacing: 15) {
                ForEach(["heart", "message", "paperplane", "bookmark"], id: \.self) { image in
                    Group {
                        if image == "bookmark" {
                            Spacer()
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: image)
                                .font(.title2)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
            Text("\(Int.random(in: 10...60)) Likes")
                .font(.callout)
                .fontWeight(.semibold)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.callout)
        }
    }
    
    @ViewBuilder
    func DynamicIslandButton() -> some View {
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
