//
//  DetailViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var movie: Movie?
    let saveMovieUseCase: SaveMovieUseCase
    init(saveMovieUseCase: SaveMovieUseCase) {
        self.saveMovieUseCase = saveMovieUseCase
    }
    func saveCurrentMovie(movie: Movie) {
        self.movie = movie
        self.saveMovieUseCase.execute(movie: movie)
    }
}
