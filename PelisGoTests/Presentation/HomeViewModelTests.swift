//
//  HomeViewModelTests.swift
//  PelisGoTests
//
//  Created by Angel Curi Laurente on 26/11/23.
//

import XCTest
@testable import PelisGo

final class HomeViewModelTests: XCTestCase {

    func testfetchMovies() {
        //given
        let dependencies = Dependencies()
        var moviesList: [Movie] = []
        var moviesListDefault: [Movie] = []
        let homeViewModel = HomeViewModel(getMoviesUseCase: dependencies.getMoviesUseCase, clearAllMoviesUseCase: dependencies.clearAllMoviesUseCase)
        //when
        homeViewModel.clearAllData()
        moviesListDefault = homeViewModel.moviesList
        //then
        XCTAssertEqual(moviesListDefault.count, 20, "La carga principal no esta funcionando")
    }
    
    func testfetchMoviesAppend() {
        //given
        let dependencies = Dependencies()
        var moviesList: [Movie] = []
        let homeViewModel = HomeViewModel(getMoviesUseCase: dependencies.getMoviesUseCase, clearAllMoviesUseCase: dependencies.clearAllMoviesUseCase)
        //when
        print("FetchTestStep1")
        homeViewModel.fetchMovies()
        print("FetchTestStep2")
        homeViewModel.fetchNextPage()
        print("FetchTestStep3")
        //then
        XCTAssertEqual(homeViewModel.moviesList.count, 40, "Las peliculas no se estan agregando a la lista")
    }

}
