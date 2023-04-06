//
//  CombineFrApp.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 05.04.2023.
//

import SwiftUI
import Firebase

@main
struct CombineFrApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDeledate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
