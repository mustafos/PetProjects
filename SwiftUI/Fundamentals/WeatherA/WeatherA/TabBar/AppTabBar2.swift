//
//  AppTabBar2.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 25.12.2023.
//

import SwiftUI

struct AppTabBar2: View {
    @State private var selectedTab: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        HStack {
                            Image(systemName: tab.rawValue)
                            Text("\(tab.rawValue.capitalized)")
                                .bold()
                                .animation(nil, value: selectedTab)
                        }
                        .tag(tab)
                    }
                }
            }
            VStack {
                Spacer()
                CustomTabBar2(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    AppTabBar2()
}
