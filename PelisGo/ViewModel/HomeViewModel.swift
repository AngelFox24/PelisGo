//
//  HomeViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var moviesList: [Movie] = []
    var currentPage: Int = 1
    let movieRepository: MovieRepository
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        fetchMovies()
    }
    // MARK: CRUD Core Data
    func fetchMovies(page: Int = 1) {
        movieRepository.getListMovies(page: page) { [weak self] result in
                    switch result {
                    case .success(let movies):
                        // Actualizar la lista de películas y notificar a las vistas
                        DispatchQueue.main.async {
                            if page == 1 {
                                self?.moviesList = movies
                            } else {
                                self?.moviesList.append(contentsOf: movies)
                            }
                            print("First: \(String(describing: self?.moviesList.first?.title))")
                            print("Last: \(String(describing: self?.moviesList.last?.title))")
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.moviesList = self?.movieRepository.getListMoviesBackUp() ?? []
                        }
                        print("Error al obtener la lista de películas: \(error.localizedDescription)")
                    }
                }
    }
    
    func fetchNextPage() {
        currentPage = currentPage + 1
        print("Current: \(currentPage)")
        fetchMovies(page: currentPage)
    }
    
    func clearAllData() {
        self.movieRepository.clearAllMovies()
    }
    
    func shouldLoadData(movie: Movie) -> Bool {
        if moviesList.isEmpty {
            return false
        } else {
            if movie == moviesList.last {
                print("Porque?: \(movie.title) and \(moviesList.last?.title)")
            }
            return movie == moviesList.last
        }
    }
    
    func lazyFetchProducts() {
        if moviesList.isEmpty {
            fetchMovies()
        }
    }
}
