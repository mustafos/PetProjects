//
//  ReadingListView.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 08.02.2024.
//

import SwiftUI

struct ReadingListView: View {
    
    @StateObject var readingViewModel = ReadingListViewModel()
    @State var showReadingDataEditor = false
    @State var selectedURL: URL?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(readingViewModel.readingData) { data in
                    NavigationLink(destination: ReadingDetailView(readingData: data,
                                                                  readingViewModel: readingViewModel)) {
                        ReadingDataRow(readingData: data)
                    }
                }
            }
            .listStyle(.sidebar)
            
            .navigationTitle("Reading List")
            .toolbar {
                Button {
                    showReadingDataEditor.toggle()
                } label: {
                    Label("Add new reading item", systemImage: "plus")
                }
                
            }
            .sheet(isPresented: $showReadingDataEditor) {
                ReadingDataEditorView(readingViewModel: readingViewModel)
            }
        }
    }
}

#Preview {
    ReadingListView()
}
