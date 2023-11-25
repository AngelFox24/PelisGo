//
//  MovieRepositoryImpl.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

protocol MovieRepository {
    func addMovie(movie: Movie) -> Bool //C
    func getListMovies(page: Int, completion: @escaping (Result<[Movie], APIError>) -> Void)
    func getListMoviesBackUp() -> [Movie]
    //func updateMovie(movie: Movie) //U
    func clearAllMovies() -> Bool //D
    
}

class MovieRepositoryImpl: MovieRepository {
    let localManager: LoMovieManager
    let remoteManager: ReMovieManager
    // let remote:  remoto, se puede implementar el remoto aqui
    init(localManager: LoMovieManager, remoteManager: ReMovieManager) {
        self.localManager = localManager
        self.remoteManager = remoteManager
    }
    //C - Create
    func addMovie(movie: Movie) -> Bool {
        self.localManager.addMovie(movie: movie)
    }
    //R - Read
    func getListMovies(page: Int, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        return self.remoteManager.getListMovies(page: page, completion: completion)
    }
    func getListMoviesBackUp() -> [Movie] {
        let movies = self.localManager.getListMovies()
        return movies
    }
    //U - Update
    /*
    func updateMovie(movie: Movie) {
        
    }
     */
    //D - Delete
    func clearAllMovies() -> Bool {
        self.localManager.clearAllMovies()
    }
}
