//
//  SaveMovieUseCase.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import Foundation

protocol SaveMovieUseCase {
    func execute(movie: Movie)
}

class SaveMovieInteractor: SaveMovieUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(movie: Movie) {
        self.movieRepository.addMovie(movie: movie)
    }
}
