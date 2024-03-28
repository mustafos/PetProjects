//
//  RealmAppApp.swift
//  RealmApp
//
//  Created by Mustafa Bekirov on 17.12.2023.
//

import SwiftUI

@main
struct RealmAppApp: App {
    
    let migrator = Migrator()
    
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstrintBasedLayoutLogUnsatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
        }
    }
}
