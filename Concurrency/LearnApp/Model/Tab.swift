//
//  Tab.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 23.03.2023.
//

import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var color: Color
    var selection: Tab
}

var tabItems = [
    TabItem(name: "Learn Now", icon: "house", color: .teal, selection: .home),
    TabItem(name: "Explore", icon: "magnifyingglass", color: .blue, selection: .explore),
    TabItem(name: "Notifications", icon: "bell", color: .red, selection: .notifications),
    TabItem(name: "Library", icon: "rectangle.stack", color: .pink, selection: .library)
]

enum Tab: String {
    case home
    case explore
    case notifications
    case library
}
