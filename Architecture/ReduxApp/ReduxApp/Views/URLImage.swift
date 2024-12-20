//
//  URLImage.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 04.01.2025.
//

import SwiftUI

struct URLImage: View {
    
    let url: String
    @ObservedObject private var imageDownloader: ImageDownloader = ImageDownloader()
    
    init(url: String) {
        self.url = url
        self.imageDownloader.downloadImage(url: self.url)
    }
    var body: some View {
        if let imageData = self.imageDownloader.downloadedData {
            let img = UIImage(data: imageData)
            return VStack {
                Image(uiImage: img!).resizable()
            }
        } else {
            return VStack {
                Image("placeholder").resizable()
            }
        }
    }
}
