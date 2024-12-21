//
//  Webservice.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 04.01.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class Webservice {
    
    func getMovieDetailsBy(imdbId: String, completion: @escaping (Result<MovieDetail?, NetworkError>) -> Void) {
        
        guard let moviesURL = URL(string: Constants.Urls.urlForMovieDetailsByImdbId(imdbId: imdbId)) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: moviesURL) { data, response, error in
            
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data)
            completion(.success(movieDetail))
            
        }.resume()
    }
    
    func getMoviesBy(search: String, completion: @escaping (Result<[Movie]?, NetworkError>) -> Void) {
        
        guard let moviesURL = URL(string: Constants.Urls.urlBySearch(search: search)) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: moviesURL) { data, response, error in
            
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
            if let movieResponse = movieResponse {
                completion(.success(movieResponse.movies))
            } else {
                completion(.failure(.invalidResponse))
            }
        }.resume()
    }
}
