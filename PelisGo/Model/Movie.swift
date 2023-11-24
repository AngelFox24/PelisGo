//
//  Movie.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String?

    var backdropURL: URL? {
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w500"),
              let path = backdrop_path,
              let url = URL(string: path, relativeTo: baseURL) else {
            return nil
        }
        return url
    }

    var posterThumbnail: URL? {
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w100"),
              let path = poster_path,
              let url = URL(string: path, relativeTo: baseURL) else {
            return nil
        }
        return url
    }

    var poster: URL? {
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w500"),
              let path = poster_path,
              let url = URL(string: path, relativeTo: baseURL) else {
            return nil
        }
        return url
    }

    static var preview: Movie {
        return Movie(adult: false,
                     id: 23834,
                     poster_path: "https://image.tmdb.org/t/p/w300",
                     title: "Free Guy",
                     overview: "some demo text here",
                     vote_average: 5.5,
                     backdrop_path: "https://image.tmdb.org/t/p/w300")
    }
}
