//
//  ReduxAppApp.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 03.01.2025.
//

import SwiftUI

@main
struct ReduxAppApp: App {
    var body: some Scene {
        
        let store = Store(reducer: appReducer, state: AppState(), middlewares: [moviesMiddleware()])
        
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
