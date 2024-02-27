//
//  ContentView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 06.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SheetWebView()
        SimpleWebView(url: URL(string: "https://mustafos.github.io")!)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
