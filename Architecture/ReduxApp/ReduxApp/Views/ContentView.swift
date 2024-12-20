//
//  ContentView.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 03.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: Store<AppState>
    @State private var search: String = ""
    
    struct Props {
        let movies: [Movie]
        let onSearch: (String) -> Void
    }
    
    private func map(state: MoviesState) -> Props {
        Props(movies: state.movies) { keyword in
            store.dispatch(action: FetchMovies(search: keyword))
        }
    }
    
    var body: some View {
        let props = map(state: store.state.movies)
        
        VStack {
            
            TextField("Search", text: $search) { _ in
                // onEditingChanged
            } onCommit: {
                props.onSearch(search)
            }.textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            List(props.movies, id: \.imdbId) { movie in
                MovieCell(movie: movie)
            }.listStyle(PlainListStyle())
        }
        .navigationTitle("Movies")
        .embedInNavigationView()
    }
}

#Preview {
    let store = Store(reducer: appReducer, state: AppState(), middlewares: [moviesMiddleware()])
    return ContentView().environmentObject(store)
}

struct MovieCell: View {
    
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top) {
            URLImage(url: movie.poster)
                .frame(width: 100, height: 130)
                .cornerRadius(10)
            Text(movie.title)
        }
    }
}
