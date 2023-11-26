//
//  MovieRepositoryTest.swift
//  PelisGoTests
//
//  Created by Angel Curi Laurente on 26/11/23.
//

import XCTest
@testable import PelisGo

final class MovieRepositoryTest: XCTestCase {

    func testgetMoviesAPI() {
        //given
        let dependencies = Dependencies()
        var moviesList: [Movie] = []
        let movieRepositoryImpl = MovieRepositoryImpl(localManager: dependencies.localMovieManager, remoteManager: dependencies.remoteMovieManager)
        //when
        movieRepositoryImpl.clearAllMovies()
        moviesList = movieRepositoryImpl.getListMovies(page: 1, pageSize: 20)
        //then
        XCTAssertEqual(moviesList.count, 20, "El Repositorio no esta retornando los items correctamente")
    }

}
