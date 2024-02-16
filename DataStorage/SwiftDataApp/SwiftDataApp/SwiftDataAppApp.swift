//
//  SwiftDataAppApp.swift
//  SwiftDataApp
//
//  Created by Mustafa Bekirov on 05.11.2023.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataAppApp: App {
    var container: ModelContainer = {
        let schema = Schema([Expense.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
//            AltContentView()
        }
        .modelContainer(container)
//        .modelContainer(for: [Expense.self])
    }
}
