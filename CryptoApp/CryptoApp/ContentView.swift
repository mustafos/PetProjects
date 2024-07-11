//
//  ContentView.swift
//  CryptoApp
//
//  Created by Mustafa Bekirov on 11.07.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                Text("Red Color")
                    .foregroundColor(Color.theme.red)
                Text("Green Color")
                    .foregroundColor(Color.theme.green)
                Text("Secondary Color")
                    .foregroundColor(Color.theme.secondaryText)
            }.font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
