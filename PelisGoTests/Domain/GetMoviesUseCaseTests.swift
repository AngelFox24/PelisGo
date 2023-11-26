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

}
