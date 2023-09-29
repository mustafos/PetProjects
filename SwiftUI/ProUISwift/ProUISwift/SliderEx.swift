//
//  SliderEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 02.05.2023.
//

import AVFoundation
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published public var maxDuration = 0.0
    private var player: AVAudioPlayer?
    
    public func play() {
        playSong(name: "song")
        player?.play()
    }
    
    public func stop() {
        player?.stop()
    }
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
    }
    
    private func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? 0.0
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct SliderEx: View {
    
    @State private var progress: Float = 0
    @ObservedObject var viewModel = PlayerViewModel()
    
    var body: some View {
        VStack {
            Slider(value: $progress, in: 0...100).padding()
            Slider(value: Binding(get: {
                Double(self.progress)
            }, set: { newValue in
                self.progress = Float(newValue)
                self.viewModel.setTime(value: Float(newValue))
            }), in: 0...viewModel.maxDuration).padding()
            
            HStack {
                Button {
                    self.viewModel.play()
                } label: {
                    Text("Play").foregroundColor(Color.white)
                }
                .frame(width: 100, height: 50).background(Color.orange).cornerRadius(10)
                
                Button {
                    self.viewModel.stop()
                } label: {
                    Text("Stop").foregroundColor(Color.white)
                }
                .frame(width: 100, height: 50).background(Color.orange).cornerRadius(10)
            }
        }
    }
}

struct SliderEx_Previews: PreviewProvider {
    static var previews: some View {
        SliderEx()
    }
}
