//
//  ImageDownloader.swift
//  PunkIPA
//

import UIKit

protocol ImageDownloader {
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class DefaultImageDownloader: ImageDownloader {
    enum ImageDownloaderError: Error {
        case noData
        case dataCorrupted
        case http(statusCode: Int)
    }
    
    private let imageCache: ImageCache
    private let session: URLSession
    
    init(
        imageCache: ImageCache,
        session: URLSession
    ) {
        self.imageCache = imageCache
        self.session = session
    }
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        // TODO: implement logic
        // Check if the image is already cached
        let cacheKey = url.absoluteString
        if let cachedImage = imageCache.getImage(forKey: cacheKey) {
            completion(.success(cachedImage))
            return
        }
        
        // Image not in cache, download it
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            // Process the result using the helper method
            let result = self.processResult(data: data, response: response, error: error)
            
            // Store the image in the cache if the download was successful
            self.storeImageIfNeeded(from: result, for: cacheKey)
            
            // Call the completion handler with the result
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        task.resume()
    }
}

private extension DefaultImageDownloader {
    func storeImageIfNeeded(from result: Result<UIImage, Error>, for key: String) {
        switch result {
        case .success(let image):
            imageCache.setImage(image, key: key)
        case .failure(_):
            break
        }
    }
    
    func processResult(data: Data?, response: URLResponse?, error: Error?) -> Result<UIImage, Error> {
        if let error = error {
            return .failure(error)
        }
        
        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            return .failure(ImageDownloaderError.http(statusCode: response.statusCode))
        }
        
        guard let data = data, !data.isEmpty else {
            return .failure(ImageDownloaderError.noData)
        }
        
        guard let image = UIImage(data: data) else {
            return .failure(ImageDownloaderError.dataCorrupted)
        }
        
        return .success(image)
    }
}
