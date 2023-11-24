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
    func getListMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        return self.remoteManager.getListMovies(completion: completion)
    }
    func getListMoviesBackUp() -> [Movie] {
        print("Se ingreso a Repo")
        let movies = self.localManager.getListMovies()
        for movie in movies {
            print("Repository")
            print("id: \(String(describing: movie.id))")
            print("Titulo: \(String(describing: movie.title))")
            print("URL: \(String(describing: movie.poster_path))")
        }
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
