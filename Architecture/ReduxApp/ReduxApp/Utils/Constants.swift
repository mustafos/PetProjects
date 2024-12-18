//
//  Constants.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 04.01.2025.
//

import Foundation

struct Constants {
    struct ApiKeys {
        static let omdbIdKey = "b2474786"
    }
    
    struct Urls {
        static func urlBySearch(search: String) -> String {
            "http://www.omdbapi.com/?s=\(search)&page=1&apikey=\(ApiKeys.omdbIdKey)"
        }
        
        static func urlForMovieDetailsByImdbId(imdbId: String) -> String {
            "http://www.omdbapi.com/?i=\(imdbId)&apikey=\(ApiKeys.omdbIdKey)"
        }
    }
}
