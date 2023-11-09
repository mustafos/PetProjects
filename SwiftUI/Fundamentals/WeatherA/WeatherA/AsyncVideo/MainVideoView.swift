//
//  MainVideoView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 27.10.2023.
//

import SwiftUI
import PhotosUI
import AVKit

struct MainVideoView: View {
    @StateObject var viewModel = VideoViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(videos) { videos in
                    CollectionView(model: videos)
                }
            }
            .navigationTitle("Video")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $viewModel.selectedItem, 
                                 matching: .any(of: [.videos, .not(.images)])) {
                        Image(systemName: "plus")
                            .renderingMode(.template)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    MainVideoView()
}

struct CollectionView: View {
    let model: Video
    var body: some View {
        VStack {
            Text(model.name)
            VideoPlayer(player: AVPlayer(url: (URL(string: model.video)!)))
                .frame(height: 250)
        }
    }
}
