//
//  HomeViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var moviesList: [Movie] = []
    let movieRepository: MovieRepository
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        fetchMovies()
    }
    // MARK: CRUD Core Data
    func fetchMovies() {
        let moviesBackUp = self.movieRepository.getListMoviesBackUp()
        movieRepository.getListMovies { [weak self] result in
                    switch result {
                    case .success(let movies):
                        // Actualizar la lista de películas y notificar a las vistas
                        DispatchQueue.main.async {
                            self?.moviesList = movies
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            print("Se buscara en local")
                            self?.moviesList = moviesBackUp
                            for movie2 in moviesBackUp {
                                print("ViewModelBK")
                                print("id: \(String(describing: movie2.id))")
                                print("Titulo: \(String(describing: movie2.title))")
                                print("URL: \(String(describing: movie2.poster_path))")
                            }
                            if let list = self?.moviesList {
                                for movie in list {
                                    print("ViewModel")
                                    print("id: \(String(describing: movie.id))")
                                    print("Titulo: \(String(describing: movie.title))")
                                    print("URL: \(String(describing: movie.poster_path))")
                                }
                            }
                        }
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
