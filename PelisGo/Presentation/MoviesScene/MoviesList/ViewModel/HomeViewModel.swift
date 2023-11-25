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
    
    private let getMoviesUseCase: GetMoviesUseCase
    private let clearAllMoviesUseCase: ClearAllMoviesUseCase
    
    init(getMoviesUseCase: GetMoviesUseCase, clearAllMoviesUseCase: ClearAllMoviesUseCase) {
        self.getMoviesUseCase = getMoviesUseCase
        self.clearAllMoviesUseCase = clearAllMoviesUseCase
        fetchMovies()
    }
    
    func fetchMovies(page: Int = 1) {
        self.moviesList += self.getMoviesUseCase.execute(page: page)
    }
    
    func fetchNextPage() {
        currentPage = currentPage + 1
        fetchMovies(page: currentPage)
    }
    
    func clearAllData() {
        clearAllMoviesUseCase.execute()
    }
    
    func shouldLoadData(movie: Movie) -> Bool {
        if moviesList.isEmpty {
            return false
        } else {
            return movie == moviesList.last
        }
    }
    
    func lazyFetchProducts() {
        if moviesList.isEmpty {
            fetchMovies()
        }
    }
}
