//
//  LearnApp.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 12.03.2023.
//

import SwiftUI

@main
struct LearnApp: App {
    @StateObject var model = Model() // Avoid calling multiple times, ensures that model initilize once and follows the lifecycle of the app
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
