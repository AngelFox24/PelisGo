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
            CustomAsyncImageView(id: movie.id, urlProducto: movie.poster?.absoluteString ?? "", sizeWidth: 120, sizeHeight: 200)
        })
    }
}

#Preview {
    HStack{
        Spacer()
        MovieCardView(movie: Movie.preview)
        Spacer()
        MovieCardView(movie: Movie.preview)
        Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray)
}
