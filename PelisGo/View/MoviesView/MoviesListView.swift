//
//  MoviesListView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct MoviesListView: View {
    @EnvironmentObject var moviesListViewModel: MoviesListViewModel
    @EnvironmentObject var movieDetailViewModel: MovieDetailViewModel
    @EnvironmentObject var navManager: NavManager
    var body: some View {
        VStack(spacing: 0) {
            if moviesListViewModel.moviesList.count == 0 {
                VStack {
                    Button(action: {
                    }, label: {
                        VStack(content: {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.custom("Artifika-Regular", size: 90))
                                .foregroundColor(.blue)
                            Text("Recargar.")
                                .foregroundColor(.blue)
                                .padding(.horizontal, 20)
                                .font(.custom("Artifika-Regular", size: 18))
                        })
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack(content: {
                    List {
                        ForEach(moviesListViewModel.moviesList) { movie in
                            MovieCardView(movie: movie)
                                .onTapGesture {
                                    movieDetailViewModel.saveCurrentMovie(movie: movie)
                                    navManager.goToMovieDetail()
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                })
                .navigationDestination(for: NavPathsEnum.self, destination: { view in
                    if view == .movieDetail {
                        MovieDetailView()
                    } else {
                        let _ = print("Sin Ruta")
                    }
                })
            }
        }
        .background(Color(.gray))
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let localMovieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        let remoteMovieManager = RemoteMovieManager()
        //Repositories
        let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //ViewModel
        let moviesListViewModel = MoviesListViewModel(movieRepository: movieRepository)
        let movieDetailViewModel = MovieDetailViewModel(movieRepository: movieRepository)
        MoviesListView()
            .environmentObject(moviesListViewModel)
            .environmentObject(movieDetailViewModel)
    }
}
