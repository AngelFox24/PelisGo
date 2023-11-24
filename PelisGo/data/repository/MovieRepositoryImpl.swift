//
//  MovieRepositoryImpl.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

protocol MovieRepository {
    func addMovie(movie: Movie) -> Bool //C
    func getListMovies() -> [Movie]
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
    func getListMovies() -> [Movie] {
        var movieList: [Movie] = []
        self.remoteManager.getListMovies { [weak self] result in
            switch result {
            case .success(let movies):
                // Actualizar la lista de películas y notificar a las vistas
                DispatchQueue.main.async {
                   movieList = movies
                }
            case .failure(let error):
                print("Error al obtener la lista de películas: \(error.localizedDescription)")
            }
        }
        print("return ok: \(movieList[1].title)")
        return movieList
        //return self.remoteManager.getListMovies(completion: completion)
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
