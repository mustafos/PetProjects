//
//  AppTabBarView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 26.12.2023.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selectTab: String = "house"
    
    let tabs = ["house", "newspaper", "message", "person"]
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectTab) {
                Text("Home")
                    .tag("house")
                Text("News")
                    .tag("newspaper")
                Text("Message")
                    .tag("message")
                Text("Profile")
                    .tag("person")
            }
            
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    Spacer()
                    TabBarItem(tab: tab, selected: $selectTab)
                    Spacer()
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    AppTabBarView()
}

struct TabBarItem: View {
    @State var tab: String
    @Binding var selected: String
    var body: some View {
        if tab == "person" {
            Button {
                withAnimation(.spring()) {
                    selected = tab
                }
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(selected == tab ? .green : .white)
                    
                    Image(systemName: "car")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
            }
        } else {
            ZStack {
                Button {
                    withAnimation(.spring()) {
                        selected = tab
                    }
                } label: {
                    HStack {
                        Image(systemName: tab)
                            .resizable()
                            .frame(width: 20, height: 20)
                        if selected == tab {
                            Text(tab)
                                .font(.system(size: 14))
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .opacity(selected == tab ? 1 : 0.7)
            .padding(.vertical, 10)
            .padding(.horizontal, 17)
            .background(selected == tab ? .white : .clear)
            .clipShape(Capsule())
        }
    }
}
