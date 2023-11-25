//
//  ClearAllMoviesUseCase.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import Foundation

protocol ClearAllMoviesUseCase {
    @discardableResult
    func execute() -> Bool
}

class ClearAllMoviesInteractor: ClearAllMoviesUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute() -> Bool {
        return movieRepository.clearAllMovies()
    }
}
