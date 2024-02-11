//
//  SheetWebView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 07.02.2024.
//

import SwiftUI

struct SheetWebView: View {
    @State private var isSheetPresented = false
    @State private var isLoading = true
    let url = URL(string: "https://mustafos.github.io")
    
    var body: some View {
        Button(action: {
            isSheetPresented = true
        }) {
            Text("Open Web Page")
        }
        .sheet(isPresented: $isSheetPresented) {
            VStack(spacing: 0) {
                #if os(macOS)
                HStack {
                    Text(url?.absoluteString ?? "")
                    Spacer()
                    Button {
                        isSheetPresented.toggle()
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                            .labelStyle(.iconOnly)
                    }
                }
                .padding(10)
                #endif
                LoadingWebView(url: url)
                    .frame(minWidth: 300, minHeight: 300)
            }
        }
    }
}

#Preview {
    SheetWebView()
}
