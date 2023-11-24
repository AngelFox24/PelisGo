//
//  MovieRepositoryImpl.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

protocol MovieRepository {
    func addMovie(movie: Movie) -> Bool //C
    func getListMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
    //func updateMovie(movie: Movie) //U
    func deleteMovie(movie: Movie) -> Bool //D
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
    func getListMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        return self.remoteManager.getListMovies(completion: completion)
    }
    //U - Update
    /*
    func updateMovie(movie: Movie) {
        
    }
     */
    //D - Delete
    func deleteMovie(movie: Movie) -> Bool {
        self.localManager.deleteMovie(movie: movie)
    }
}
