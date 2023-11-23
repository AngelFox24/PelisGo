//
//  MovieRepositoryImpl.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

protocol MovieRepository {
    func addMovie(movie: Movie) -> Bool //C
    func getListMovies() -> [Movie] //R
    //func updateMovie(movie: Movie) //U
    func deleteMovie(movie: Movie) -> Bool //D
}

class MovieRepositoryImpl: MovieRepository {
    let manager: MovieManager
    // let remote:  remoto, se puede implementar el remoto aqui
    init(manager: MovieManager) {
        self.manager = manager
    }
    //C - Create
    func addMovie(movie: Movie) -> Bool {
        self.manager.addMovie(movie: movie)
    }
    //R - Read
    func getListMovies() -> [Movie] {
        return self.manager.getListMovies()
    }
    //U - Update
    /*
    func updateMovie(movie: Movie) {
        
    }
     */
    //D - Delete
    func deleteMovie(movie: Movie) -> Bool {
        self.manager.deleteMovie(movie: movie)
    }
}
