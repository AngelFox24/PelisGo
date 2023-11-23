//
//  MovieCardView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct MovieCardView: View {
    var movie: Movie
    var body: some View {
        VStack(content: {
            CustomAsyncImageView(id: movie.id, urlProducto: movie.posterPath, sizeWidth: 120, sizeHeight: 200)
        })
    }
}

#Preview {
    HStack{
        Spacer()
        MovieCardView(movie: Movie(id: 2142, title: "Perritos", posterPath: "https://image.tmdb.org/t/p/w500/aTvePCU7exLepwg5hWySjwxojQK.jpg", voteAverage: 12.2, releaseDate: Date(), overview: "ssdasf"))
        Spacer()
        MovieCardView(movie: Movie(id: 51253, title: "Perritos", posterPath: "https://image.tmdb.org/t/p/w500/aTvePCU7exLepwg5hWySjwxojQK.jpg", voteAverage: 12.2, releaseDate: Date(), overview: "ssdasf"))
        Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray)
}
