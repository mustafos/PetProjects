//
//  LegoSwiftUIApp.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 11.02.2024.
//

import SwiftUI
import TipKit

@main
struct LegoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            TipView()
//                .task {
//                    try? Tips.resetDatastore()
//                    try? Tips.configure([
//                        .displayFrequency(.immediate),
//                        .datastoreLocation(.applicationDefault)
//                    ])
//                }
            PDFViewer()
        }
    }
}
