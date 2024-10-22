//
//  ContentView.swift
//  vpn_app
//
//  Created by Mustafa Bekirov on 04.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CountryViewModel()
    
    var body: some View {
        HomeView()
            .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
