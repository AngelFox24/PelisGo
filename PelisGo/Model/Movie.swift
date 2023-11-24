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
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: backdrop_path ?? "")
    }

    var posterThumbnail: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w100")
        return baseURL?.appending(path: poster_path ?? "")
    }

    var poster: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: poster_path ?? "")
    }
    static var preview: Movie {
        return Movie(adult: false,
                     id: 23834,
                     poster_path: "/NNxYkU70HPurnNCSiCjYAmacwm.jpg",
                     title: "Free Guy",
                     overview: "some demo text here",
                     vote_average: 5.5,
                     backdrop_path: "/kKxwzAbrA2mY7ixsO3f9uLF7S6v.jpg")
    }
}
