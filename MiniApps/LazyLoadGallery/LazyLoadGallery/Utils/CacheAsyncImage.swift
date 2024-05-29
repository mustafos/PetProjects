//
//  CacheAsyncImage.swift
//  LazyLoadGallery
//
//  Created by Mustafa Bekirov on 28.05.2024.
//

import SwiftUI

struct CacheAsyncImage: View {
    var image: String
    
    var body: some View {
        AsyncImage(url: URL(string: image)) { phase in
            switch phase {
            case .empty:
                RoundedRectangle(cornerRadius: 12)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .overlay {
                        ProgressView()
                    }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 200)
            @unknown default:
                EmptyView()
            }
        }
    }
}
