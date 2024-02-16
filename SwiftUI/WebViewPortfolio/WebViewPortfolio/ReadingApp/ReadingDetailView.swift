//
//  ReadingDetailView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 08.02.2024.
//

import SwiftUI

struct ReadingDetailView: View {
    
    let readingData: ReadingData
    @ObservedObject var readingViewModel: ReadingListViewModel
    
    @State private var showConfirmationDialog: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        LoadingWebView(url: readingData.url)
            .edgesIgnoringSafeArea(.bottom)
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(readingData.title)
        #endif
            .toolbar {
                Button(role: .destructive) {
                    showConfirmationDialog.toggle()
                } label: {
                    Label("Delete", systemImage: "trash")
                }.foregroundColor(.pink)

            }
            
            .confirmationDialog("Are you sure you want to delete this url?",
                                isPresented: $showConfirmationDialog,
                                titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    dismiss()
                    readingViewModel.remove(readingData)
                }
            }
           
    }
}

#Preview {
    ReadingDetailView(readingData: ReadingData.example(),
                      readingViewModel: ReadingListViewModel())
}
