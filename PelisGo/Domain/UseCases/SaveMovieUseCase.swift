//
//  SaveMovieUseCase.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import Foundation

protocol SaveMovieUseCase {
    @discardableResult
    func execute(movie: Movie) -> Bool
}

final class SaveMovieInteractor: SaveMovieUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(movie: Movie) -> Bool {
        return self.movieRepository.addMovie(movie: movie)
    }
}
