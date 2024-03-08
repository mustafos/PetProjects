//
//  SimpleWebView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 07.02.2024.
//

import SwiftUI
import WebKit

struct SimpleWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        wkwebView.load(URLRequest(url: url))
        return wkwebView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    SimpleWebView(url: URL(string: "https://mustafos.github.io")!)
}
