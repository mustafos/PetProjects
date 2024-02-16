//
//  LoadingWebView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 07.02.2024.
//

import SwiftUI

struct LoadingWebView: View {
    @State private var isLoading = true
    @State private var error: Error? = nil
    let url: URL?
    
    var body: some View {
        ZStack {
            if let error = error {
                Text(error.localizedDescription)
                    .foregroundColor(.pink)
            } else if let url = url {
                PlatformIndependentWebView(url: url,
                                           isLoading: $isLoading,
                                           error: $error)
    
                if isLoading {
                    ProgressView()
                        .scaleEffect(2)
                }
            } else {
                Text("Sorry, we could not load this url.")
            }
 
        }
    }
}

#Preview {
    LoadingWebView(url: URL(string: "https://mustafos.github.io"))
}
