//
//  MovieDetailViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    /*
    let movieRepository: MovieRepository
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    // MARK: CRUD Core Data
    func fetch() {
        moviesList = movieRepository.getListMovies()
    }
    func lazyFetchProducts() {
        if moviesList.isEmpty {
            fetch()
        }
    }
     */
}
