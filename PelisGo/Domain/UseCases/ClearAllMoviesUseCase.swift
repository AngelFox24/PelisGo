//
//  ClearAllMoviesUseCase.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import Foundation

protocol ClearAllMoviesUseCase {
    func execute()
}

class ClearAllMoviesInteractor: ClearAllMoviesUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute() {
        movieRepository.clearAllMovies()
    }
}
