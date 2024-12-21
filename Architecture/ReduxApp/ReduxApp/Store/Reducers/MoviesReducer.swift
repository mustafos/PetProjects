//
//  MoviesReducer.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 05.01.2025.
//

import Foundation

func moviesReducer(_ state: MoviesState, _ action: Action) -> MoviesState {
    var state = state
    
    switch action {
    case let action as SetMovies:
        state.movies = action.movies
    case let action as SetMovieDetails:
        state.selectedMovieDetail = action.details
    default:
        break
    }
    return state
}
