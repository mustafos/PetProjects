//
//  MacSettingsCommands.swift
//  AlgoApp
//
//  Created by Mustafa Bekirov on 31.01.2025.
//

import SwiftUI

struct MacSettingsCommands: Commands {
    @Bindable private var settings = SortingSettings.shared
    
    var body: some Commands {
        CommandMenu("Settings") {
            Group {
                Section("Visualization") {
                    Toggle("Enable Animations", isOn: $settings.animationsEnabled)
                        .keyboardShortcut("a")
                    Toggle("Show Bar Values", isOn: $settings.showBarValues)
                        .keyboardShortcut("b")
                    Toggle("Show Timer", isOn: $settings.showTimer)
                        .keyboardShortcut("t")
                }
                
                Divider()
                
                Section("Animation Speed") {
                    Menu("Preset Speeds") {
                        Button("Fast (0.1s)") { settings.animationDuration = 0.1 }
                        Button("Normal (0.5s)") { settings.animationDuration = 0.5 }
                        Button("Slow (1.0s)") { settings.animationDuration = 1.0 }
                        Button("Very Slow (2.0s)") { settings.animationDuration = 2.0 }
                    }
                    Text("Current: \(settings.animationDuration, specifier: "%.1f") seconds")
                }
                
                Section("Data Set") {
                    Menu("Data Set Type") {
                        ForEach(DataSetType.allCases, id: \.self) { type in
                            Button(type.rawValue) {
                                settings.dataSetType = type
                            }
                        }
                    }
                    Text("Current: \(settings.dataSetType.rawValue)")
                }
            }
        }
    }
}
