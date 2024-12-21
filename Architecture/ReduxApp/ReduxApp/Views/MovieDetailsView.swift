//
//  MovieDetailsView.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 05.01.2025.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var store: Store<AppState>
    let movie: Movie
    
    struct Props {
        let details: MovieDetail?
        let onLoadMovieDetails: (String) -> Void
    }
    
    private func map(state: MoviesState) -> Props {
        Props(details: state.selectedMovieDetail) { imdbId in
            store.dispatch(action: FetchMovieDetail(imdbId: imdbId))
        }
    }
    
    var body: some View {
        VStack {
            let props = map(state: store.state.movies)
            
            Group {
                if let details = props.details {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            URLImage(url: details.poster)
                            Spacer()
                        }
                        
                        Text(details.title)
                            .padding(5)
                            .font(.title)
                        Text(details.plot)
                            .padding(5)
                        
                        HStack {
                            Text("Rating")
                            RatingView(rating: .constant(details.imdbRating.toInt()))
                        }.padding()
                        
                        Spacer()
                        
                    }
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                props.onLoadMovieDetails(movie.imdbId)
            }
        }
    }
}

#Preview {
    let store = Store(reducer: appReducer, state: AppState(), middlewares: [moviesMiddleware()])
    return MovieDetailsView(movie: Movie(title: "Smile", poster: "https:// m.media-amazon.com/images/M/MV5BNjFh-MzBINzktMj-E2NiOOYTMy-LWI2YWUt-YmM1N2Qx-MDQwZmZh-XkEyXkFqcGc-@._V1_SX300jpg", imdbId: "tt15474916")).environmentObject(store)
}
