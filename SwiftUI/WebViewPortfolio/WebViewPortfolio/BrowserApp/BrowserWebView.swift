//
//  BrowserWebView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 09.02.2024.
//

import SwiftUI
import WebKit

struct BrowserWebView: UIViewRepresentable {
    let url: URL
    @ObservedObject var viewModel: BrowserViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        viewModel.webView = webView
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
