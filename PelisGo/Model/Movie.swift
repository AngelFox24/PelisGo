//
//  Movie.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

struct Movie: Identifiable {
    let id: Int
    let title: String
    let posterPath: String
    let voteAverage: Double
    let releaseDate: Date
    let overview: String
}
