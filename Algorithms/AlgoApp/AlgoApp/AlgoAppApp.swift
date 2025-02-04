//
//  AlgoAppApp.swift
//  AlgoApp
//
//  Created by Mustafa Bekirov on 30.01.2025.
//

import SwiftUI

@main
struct AlgoAppApp: App {
    @State private var settings = SortingSettings.shared
    @State private var showAbout = false
    
    var body: some Scene {
        WindowGroup {
            SortingView()
                .environment(\.sortingSettings, settings)
                .sheet(isPresented: $showAbout) {
                    AboutView()
                }
        }
#if os(macOS)
        .commands {
            // Replace app info menu with About
            CommandGroup(replacing: .appInfo) {
                Button("About Sorting Visualizer") {
                    showAbout = true
                }
            }
            
            // Add our custom settings commands
            MacSettingsCommands()
            
            // Remove View menu
            CommandGroup(replacing: .sidebar) { }
            
            // Remove Window menu
            CommandGroup(replacing: .windowList) { }
            
            // Remove File menu
            CommandGroup(replacing: .newItem) { }
            
            // Remove Edit menu
            CommandGroup(replacing: .pasteboard) { }
            CommandGroup(replacing: .undoRedo) { }
        }
#endif
    }
}
