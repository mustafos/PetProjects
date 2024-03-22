//
//  DynamicIslandExampleApp.swift
//  DynamicIslandExample
//
//  Created by Mustafa Bekirov on 16.03.2024.
//

import SwiftUI
import GoogleMobileAds

@main
struct DynamicIslandExampleApp: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
