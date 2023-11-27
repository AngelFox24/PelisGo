//
//  MovieRepositoryImpl.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

protocol MovieRepository {
    func addMovie(movie: Movie) -> Bool
    func getListMoviesBackUp(page: Int, pageSize: Int) -> [Movie]
    func getListMovies(page: Int, pageSize: Int) -> [Movie]
    func clearAllMovies() -> Bool
}

class MovieRepositoryImpl: MovieRepository {
    let localManager: LoMovieManager
    let remoteManager: ReMovieManager
    init(localManager: LoMovieManager, remoteManager: ReMovieManager) {
        self.localManager = localManager
        self.remoteManager = remoteManager
    }
    func addMovie(movie: Movie) -> Bool {
        self.localManager.addMovie(movie: movie)
    }
    func getListMovies(page: Int, pageSize: Int) -> [Movie] {
        var moviesResult: [Movie] = []
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        self.remoteManager.getListMovies(page: page) { [weak self] result in
            switch result {
            case .success(let movies):
                moviesResult = movies
                dispatchGroup.leave()
            case .failure(let error):
                moviesResult = self?.getListMoviesBackUp(page: page, pageSize: 20) ?? []
                print("Error Network: \(error)")
                dispatchGroup.leave()
            }
        }
        dispatchGroup.wait()
        return moviesResult
    }
    func getListMoviesBackUp(page: Int, pageSize: Int) -> [Movie]  {
        return self.localManager.getListMovies(page: page, pageSize: pageSize)
    }
    func clearAllMovies() -> Bool {
        self.localManager.clearAllMovies()
    }
}
