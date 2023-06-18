//
//  dwApp.swift
//  dw
//
//  Created by Mustafa Bekirov on 18.06.2023.
//

import SwiftUI

@main
struct dwApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
