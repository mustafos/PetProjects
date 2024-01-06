//
//  VideoPlayer.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 27.10.2023.
//

import SwiftUI
import AVKit

struct VideoPlayer: View {
    @State var player = AVPlayer()
    var videoUrl: String = "https://jmddiuaqzvnoepqhghuh.supabase.co/storage/v1/object/public/pojmy/eTesty_1649.mp4"
    var body: some View {
        VideoPlayer(player: player)
            .onAppear() {
                player = AVPlayer(url: URL(string: videoUrl)!)
            }
    }
}

#Preview {
    VideoPlayer()
}
