//
//  MoviesListViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var moviesList: [Movie] = []
    let movieRepository: MovieRepository
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        fetchMovies()
    }
    // MARK: CRUD Core Data
    func fetchMovies() {
        self.moviesList = self.movieRepository.getListMovies()
    }
    
    func lazyFetchProducts() {
        if moviesList.isEmpty {
            fetchMovies()
        }
    }
}
