//
//  MovieRepositoryImpl.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

protocol MovieRepository {
    func addMovie(movie: Movie) -> Bool //C
    func getListMovies(page: Int) -> [Movie]
    func getListMoviesBackUp() -> [Movie]
    func clearAllMovies() -> Bool //D
    
}

class MovieRepositoryImpl: MovieRepository {
    let localManager: LoMovieManager
    let remoteManager: ReMovieManager
    init(localManager: LoMovieManager, remoteManager: ReMovieManager) {
        self.localManager = localManager
        self.remoteManager = remoteManager
    }
    //C - Create
    func addMovie(movie: Movie) -> Bool {
        self.localManager.addMovie(movie: movie)
    }
    //R - Read
    func getListMovies(page: Int) -> [Movie] {
        var moviesResult: [Movie] = []
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        self.remoteManager.getListMovies(page: page) { [weak self] result in
            switch result {
            case .success(let movies):
                moviesResult = movies
                dispatchGroup.leave()
            case .failure(let error):
                moviesResult = self?.getListMoviesBackUp() ?? []
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.wait()
        
        return moviesResult
    }
    
    func getListMoviesBackUp() -> [Movie] {
        return self.localManager.getListMovies()
    }
    
    func clearAllMovies() -> Bool {
        self.localManager.clearAllMovies()
    }
}
