//
//  GetMoviesUseCase.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import Foundation

protocol GetMoviesUseCase {
    func execute(page: Int) -> [Movie]
}

class GetMovieInteractor: GetMoviesUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(page: Int) -> [Movie] {
        return self.movieRepository.getListMovies(page: page, pageSize: 20)
    }
}
