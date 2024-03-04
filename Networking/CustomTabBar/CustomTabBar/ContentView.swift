//
//  ContentView.swift
//  CustomTabBar
//
//  Created by Mustafa Bekirov on 07.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabBar = .house
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNetworkAlert = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(TabBar.allCases, id: \.rawValue) { tab in
                        Group {
                            if tab == .figure {
                                Text("figure")
                            } else if tab == .house {
                                Text("house")
                            } else if tab == .person {
                                if networkMonitor.isConnected {
                                    Text("person")
                                } else {
                                    NoNetworkView()
                                }
                            }
                        }
                        .tag(tab)
                    }
                }
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    ContentView()
}
