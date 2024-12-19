//
//  Store.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 03.01.2025.
//

import Foundation

typealias Dispatcher = (Action) -> Void

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middlewere<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

protocol ReduxState { }

struct AppState: ReduxState {
    var movies = MoviesState()
}

struct MoviesState: ReduxState {
    var movies = [Movie]()
}

protocol Action { }

struct FetchMovies: Action {
    let search: String
}

struct SetMovies: Action {
    let movies: [Movie]
}

class Store<StoreState: ReduxState>: ObservableObject {
    
    var reducer: Reducer<StoreState>
    @Published var state: StoreState
    var middlewares: [Middlewere<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState, middlewares: [Middlewere<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        
        // run all middlewares
        middlewares.forEach { middlewares in
            middlewares(state, action, dispatch)
        }
    }
}
