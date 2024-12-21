//
//  MovieDetail.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 05.01.2025.
//

import Foundation

struct MovieDetail: Decodable {
    
    let title: String
    let plot: String
    let imdbRating: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case plot = "Plot"
        case imdbRating = "imdbRating"
        case poster = "Poster"
    }
}
