//
//  VideoViewModel.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 27.10.2023.
//

import SwiftUI
import PhotosUI

class VideoViewModel: ObservableObject {
    @Published var videos = [Video]()
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await uploadVideo() } } }
    
    func uploadVideo() async throws {
        guard let item = selectedItem else { return }
        guard let videoData = try await item.loadTransferable(type: Data.self) else { return }
        
        print("DEBUG: Video data is \(videoData)")
    }
    
    func fetchVideo() async throws {
        
    }
}
