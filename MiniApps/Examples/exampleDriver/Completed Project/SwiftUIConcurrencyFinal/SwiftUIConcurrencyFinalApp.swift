//
//  SwiftUIConcurrencyFinalApp.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-15.
//

import SwiftUI

@main
struct SwiftUIConcurrencyFinalApp: App {
    @StateObject var courseViewModel = CourseViewModel()
    @StateObject var sectionViewModel = SectionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(courseViewModel)
                .environmentObject(sectionViewModel)
        }
    }
}
