//
//  GetMoviesUseCaseTests.swift
//  PelisGoTests
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import XCTest
@testable import PelisGo

final class GetMoviesUseCaseTests: XCTestCase {

    func testGetMoviesPageNegative() {
        //given
        let dependencies = Dependencies()
        var page: Int = -1
        let getMovieList = GetMovieInteractor(movieRepository: dependencies.movieRepository)
        //when
        let moviesList = getMovieList.execute(page: page)
        //then
        XCTAssertEqual(moviesList.count, 0)
    }
    func testGetMoviesPage1() {
        //given
        let dependencies = Dependencies()
        var page: Int = 1
        let getMovieList = GetMovieInteractor(movieRepository: dependencies.movieRepository)
        //when
        let moviesList = getMovieList.execute(page: page)
        //then
        XCTAssertEqual(moviesList.count, 20)
    }
    func testGetMoviesMultiplePages() {
        //given
        let dependencies = Dependencies()
        let getMovieList = GetMovieInteractor(movieRepository: dependencies.movieRepository)
        //when
        let moviesList = getMovieList.execute(page: 1)
        let moviesList2 = getMovieList.execute(page: 2)
        //then
        XCTAssertEqual(moviesList.count, 20, "La pagina 1 no carga correctamente")
        XCTAssertEqual(moviesList2.count, 20, "La pagina 2 no carga correctamente")
        XCTAssertFalse(moviesList.first != nil ? moviesList2.contains(moviesList.first!) : false, "Las peliculas se repiten entre las paginas")
    }
}
