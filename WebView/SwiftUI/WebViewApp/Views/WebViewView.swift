//
//  WebViewView.swift
//  WebViewApp
//
//  Created by Mustafa Bekirov on 11.09.2024.
//

import SwiftUI

struct WebViewView: View {
    @EnvironmentObject private var webViewManager: WebViewManager
    @State private var urlString: String = ""

    var body: some View {
        VStack {
            TextField("Enter URL", text: $urlString, onCommit: {
                let requestBody = webViewManager.createRequestBody(url: urlString)
                webViewManager.openWebViewWithRequest(url: urlString, requestBody: requestBody) { response in
                    // Handle response if needed
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            WebView(urlString: urlString).ignoresSafeArea()
        }
    }
}
