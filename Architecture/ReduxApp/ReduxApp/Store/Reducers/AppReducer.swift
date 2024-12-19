//
//  AppReducer.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 03.01.2025.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
    var state = state
    state.movies = moviesReducer(state.movies, action)
    return state
}
