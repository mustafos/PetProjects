//
//  BeerListViewModel.swift
//  PunkIPA
//

import UIKit

final class RickAndMortyCharacterViewModel {
    private(set) var items: Characters = []
    private let imageDownloader: ImageDownloader
    private let rickAndMortyAPI: RickAndMortyCharacterNetworkServiceProtocol

    init(
        imageDownaloader: ImageDownloader,
        rickAndMortyAPI: RickAndMortyCharacterNetworkServiceProtocol
    ) {
        self.imageDownloader = imageDownaloader
        self.rickAndMortyAPI = rickAndMortyAPI
    }
}

extension RickAndMortyCharacterViewModel {
    func fetchCharacters(completion: @escaping () -> Void) {
        rickAndMortyAPI.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.items = characters
                completion() // Notify the view that the data is ready
            case .failure(let error):
                print("Failed to fetch characters: \(error)")
                completion() // Notify the view even if there was an error, so it can handle it
            }
        }
    }

    func loadImage(for urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        imageDownloader.downloadImage(from: url) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Failed to download image: \(error)")
                completion(nil)
            }
        }
    }
}
