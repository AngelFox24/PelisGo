//
//  NetworkServiceTest.swift
//  PelisGoTests
//
//  Created by Angel Curi Laurente on 26/11/23.
//

import XCTest
@testable import PelisGo

final class NetworkServiceTest: XCTestCase {

    func testgetMoviesAPI() {
        //given
        var moviesList: [Movie] = []
        let getMovieList = RemoteMovieManager()
        //when
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getMovieList.getListMovies(page: 1) { [weak self] result in
            switch result {
            case .success(let movies):
                moviesList = movies
                dispatchGroup.leave()
            case .failure(let error):
                XCTFail("Deberia retornar una lista de Peliculas, Error: \(error)")
                dispatchGroup.leave()
            }
        }
        dispatchGroup.wait()
        //then
        XCTAssertEqual(moviesList.count, 20, "La API no esta retornando los items correctamente")
    }
    func test_getMoviesMultiplesPages() {
        //given
        var moviesList: [Movie] = []
        let getMovieList = RemoteMovieManager()
        //when
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getMovieList.getListMovies(page: 1) { [weak self] result in
            switch result {
            case .success(let movies):
                moviesList = movies
                dispatchGroup.leave()
            case .failure(let error):
                XCTFail("Deberia retornar una lista de Peliculas, Error: \(error)")
                dispatchGroup.leave()
            }
        }
        dispatchGroup.wait()
        
        dispatchGroup.enter()
        getMovieList.getListMovies(page: 2) { [weak self] result in
            switch result {
            case .success(let movies):
                moviesList.append(contentsOf: movies)
                dispatchGroup.leave()
            case .failure(let error):
                XCTFail("Deberia retornar una lista de Peliculas, Error: \(error)")
                dispatchGroup.leave()
            }
        }
        dispatchGroup.wait()
        //then
        XCTAssertEqual(moviesList.count, 40, "La API no esta retornando mas de 1 pagina")
    }

}
