//
//  PlatformIndependentWebView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 07.02.2024.
//

import SwiftUI
import WebKit

struct PlatformIndependentWebView {
    
    var url: URL
    
    @Binding var isLoading: Bool
    @Binding var error: Error?
    
    func makeCoordinator() -> PlatformIndependentWebView.Coordinator {
         Coordinator(self)
     }
    
    func makeWebView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        webView.load(request)
        return webView
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: PlatformIndependentWebView
      
        init(_ uiWebView: PlatformIndependentWebView) {
            self.parent = uiWebView
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
           // print("Called when the web view begins to show content.")
        }
                
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }

        func webView(_ webView: WKWebView,
                     didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.error = error
        }
    }
}

//MARK: - extensions
#if os(macOS)
extension PlatformIndependentWebView: NSViewRepresentable {
    func makeNSView(context: Context) -> WKWebView {
        makeWebView(context: context)
    }
    func updateNSView(_ nsView: WKWebView, context: Context) {
        
    }
}
#else
extension PlatformIndependentWebView: UIViewRepresentable {

     func makeUIView(context: Context) -> WKWebView {
         makeWebView(context: context)
     }
    
     func updateUIView(_ uiView: WKWebView, context: Context) {
     }
}
#endif

#Preview {
    PlatformIndependentWebView(url: URL(string: "https://mustafos.github.io")!,
                               isLoading: .constant(false),
                               error: .constant(nil))
}
