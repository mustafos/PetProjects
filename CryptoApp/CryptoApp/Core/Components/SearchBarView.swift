//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Mustafa Bekirov on 22.07.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty
                                 ? Color.theme.secondaryText
                                 : Color.primary)
            
            TextField("Search by name or symbol...", text: $searchText)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.primary)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x: 0, y: 0
                )
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
}
