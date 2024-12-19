//
//  MoviesMiddleware.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 05.01.2025.
//

import Foundation

func moviesMiddleware() -> Middlewere<AppState> {
    return { state, action, dispatch in
        switch action {
        case let action as FetchMovies:
            Webservice().getMoviesBy(search: action.search.urlEncode()) { result in
                switch result {
                case .success(let movies):
                    if let movies = movies {
                        // set movies to the state
                        dispatch(SetMovies(movies: movies))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
    }
}
