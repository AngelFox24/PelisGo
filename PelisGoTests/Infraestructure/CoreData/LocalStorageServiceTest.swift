//
//  LocalStorageServiceTest.swift
//  PelisGoTests
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import XCTest
@testable import PelisGo

final class LocalStorageServiceTest: XCTestCase {
    func testGetMoviesPageNegative() {
        //given
        let dependencies = Dependencies()
        let page: Int = -1
        let localMovieManager = LocalMovieManager(mainContext: dependencies.mainContext)
        //when
        let moviesLocalList = localMovieManager.getListMovies(page: page, pageSize: 20)
        //then
        XCTAssertEqual(moviesLocalList.count, 0)
    }
    func test_addMovie() {
        //given
        let dependencies = Dependencies()
        let movie1 = Movie(adult: false, id: 1, poster_path: "Test_poster", title: "Test_tittle", overview: "Test_overview", vote_average: 1.2, backdrop_path: "Test_backdrop", release_date: nil)
        let localMovieManager = LocalMovieManager(mainContext: dependencies.mainContext)
        let page: Int = 1
        //when
        let success = localMovieManager.addMovie(movie: movie1)
        let moviesLocalList = localMovieManager.getListMovies(page: page, pageSize: 20)
        //then
        XCTAssertEqual(moviesLocalList.count, 1, "Core Data esta duplicando los datos")
        XCTAssertTrue(success, "Core Data falla en guardar peliculas")
        XCTAssertTrue(moviesLocalList.contains(movie1), "La pelicula no se guardo en Core Data")
    }
    func test_whenAddTwoMoviesWithSameId() {
        //given
        let dependencies = Dependencies()
        let movie1 = Movie(adult: false, id: 1, poster_path: "Test_poster", title: "Test_tittle", overview: "Test_overview", vote_average: 1.2, backdrop_path: "Test_backdrop", release_date: nil)
        let movie2 = Movie(adult: false, id: 1, poster_path: "Test_poster2", title: "Test_tittle2", overview: "Test_overview2", vote_average: 1.6, backdrop_path: "Test_backdrop2", release_date: nil)
        let localMovieManager = LocalMovieManager(mainContext: dependencies.mainContext)
        let page: Int = 1
        //when
        let success1 = localMovieManager.addMovie(movie: movie1)
        let success2 = localMovieManager.addMovie(movie: movie2)
        let moviesLocalList = localMovieManager.getListMovies(page: page, pageSize: 20)
        //then
        XCTAssertEqual(moviesLocalList.count, 1, "Core Data esta duplicando los datos")
        XCTAssertTrue(success1, "Core Data falla en guardar peliculas")
        XCTAssertTrue(success2, "Core Data falla en reemplazar peliculas")
        XCTAssertTrue(moviesLocalList.first?.poster_path == "Test_poster2", "La pelicula no se actualizo correctamente en Core Data")
    }
    func test_clearAllMovies() {
        //given
        let dependencies = Dependencies()
        let movie1 = Movie(adult: false, id: 1, poster_path: "Test_poster", title: "Test_tittle", overview: "Test_overview", vote_average: 1.2, backdrop_path: "Test_backdrop", release_date: nil)
        let movie2 = Movie(adult: false, id: 2, poster_path: "Test_poster2", title: "Test_tittle2", overview: "Test_overview2", vote_average: 1.6, backdrop_path: "Test_backdrop2", release_date: nil)
        let localMovieManager = LocalMovieManager(mainContext: dependencies.mainContext)
        let page: Int = 1
        //when
        let _ = localMovieManager.addMovie(movie: movie1)
        let _ = localMovieManager.addMovie(movie: movie2)
        let clear = localMovieManager.clearAllMovies()
        let moviesLocalList = localMovieManager.getListMovies(page: page, pageSize: 20)
        //then
        XCTAssertTrue(clear, "Core Data no esta borrando correctamente los datos")
        XCTAssertEqual(moviesLocalList.count, 0, "Core Data no esta borrando correctamente los datos")
    }
}
