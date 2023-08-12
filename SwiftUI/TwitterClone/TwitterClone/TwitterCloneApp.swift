//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Mustafa Bekirov on 26.07.2023.
//

import SwiftUI
import Firebase

@main
struct TwitterCloneApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel())
        }
    }
}
