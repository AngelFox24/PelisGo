//
//  MovieDetailView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var movieDetailViewModel: MovieDetailViewModel
    var body: some View {
        if let movieTitle = movieDetailViewModel.movie?.title {
            Text("Movie: \(movieTitle)")
        } else {
            Text("Movie: Vacío")
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let localMovieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        let remoteMovieManager = RemoteMovieManager()
        //Repositories
        let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //ViewModel
        let moviesListViewModel = MoviesListViewModel(movieRepository: movieRepository)
        let movieDetailViewModel = MovieDetailViewModel(movieRepository: movieRepository)
        MovieDetailView()
            .environmentObject(moviesListViewModel)
            .environmentObject(movieDetailViewModel)
    }
}
