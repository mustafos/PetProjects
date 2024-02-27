//
//  AdvancedWebView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 07.02.2024.
//

import SwiftUI
import WebKit

struct AdvancedWebView: UIViewRepresentable {
    
    let url: URL
    @Binding var isLoading: Bool
    @Binding var error: Error?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        wkwebView.navigationDelegate = context.coordinator
        wkwebView.load(URLRequest(url: url))
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // This space is left intentionally blank.
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: AdvancedWebView
        
        init(_ parent: AdvancedWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            //parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("loading error: \(error)")
            parent.isLoading = false
            parent.error = error
        }
    }
}

#Preview {
    AdvancedWebView(url:  URL(string: "https://mustafos.github.io")!,
                    isLoading: .constant(false),
                    error: .constant(nil))
}
