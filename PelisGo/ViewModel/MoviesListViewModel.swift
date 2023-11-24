//
//  MoviesListViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var moviesList: [Movie] = []
    let movieRepository: MovieRepository
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        fetchMovies()
    }
    // MARK: CRUD Core Data
    func fetchMovies() {
        movieRepository.getListMovies { [weak self] result in
                    switch result {
                    case .success(let movies):
                        // Actualizar la lista de películas y notificar a las vistas
                        DispatchQueue.main.async {
                            self?.moviesList = movies
                        }
                    case .failure(let error):
                        print("Error al obtener la lista de películas: \(error.localizedDescription)")
                    }
                }
    }
    
    func lazyFetchProducts() {
        if moviesList.isEmpty {
            fetchMovies()
        }
    }
}
