//
//  MovieDetailViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    let movieRepository: MovieRepository
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    func saveCurrentMovie(movie: Movie) {
        self.movie = movie
        self.movieRepository.addMovie(movie: movie)
    }
}
