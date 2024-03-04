//
//  CustomTabBarApp.swift
//  CustomTabBar
//
//  Created by Mustafa Bekirov on 07.10.2023.
//

import SwiftUI

@main
struct CustomTabBarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NetworkMonitor())
        }
    }
}
