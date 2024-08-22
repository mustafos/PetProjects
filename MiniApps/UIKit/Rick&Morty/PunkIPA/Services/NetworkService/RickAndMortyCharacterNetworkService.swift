//
//  RickAndMortyCharacterNetworkService.swift
//  PunkIPA
//

import Foundation

protocol RickAndMortyCharacterNetworkServiceProtocol {
    func fetchCharacters(completion: @escaping (Result<Characters, Error>) -> Void)
}

final class RickAndMortyCharacterNetworkService: RickAndMortyCharacterNetworkServiceProtocol {
    enum BeerNetworkError: Error {
        case invalidResponse
        case hasError
    }
    
    private let baseURL: URL
    private var characterEndpointURL: URL { baseURL.appendingPathComponent("character") }
    private let session: URLSession
    
    init(baseURL: URL, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func fetchCharacters(completion: @escaping (Result<Characters, Error>) -> Void) {
        // TODO: implement logic
        let request = URLRequest(url: characterEndpointURL)
        
        session.dataTask(with: request) { [weak self] data, response, error in
            // Pass the response to the handleResponse method
            self?.handleResponse(completion: completion, data: data, response: response, error: error)
        }.resume()
        
    }
}

private extension RickAndMortyCharacterNetworkService {
    func handleResponse(
        completion: @escaping (Result<Characters, Error>) -> Void,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) {
        // Check if there was an error
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Check if the response is a valid HTTP response
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(BeerNetworkError.invalidResponse))
            return
        }
        
        // Check if data is available
        guard let data = data else {
            completion(.failure(BeerNetworkError.hasError))
            return
        }
        
        do {
            // Decode the data into Characters
            let rickAndMortyData = try JSONDecoder().decode(RickAndMorty.self, from: data)
            completion(.success(rickAndMortyData.results))
        } catch {
            completion(.failure(error))
        }
    }
}
