//
//  MovieCardView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct MovieCardView: View {
    var movie: Movie
    var save: Bool = true
    var body: some View {
        VStack(content: {
            CustomAsyncImageView(id: movie.id.description + "_poster_path", urlProducto: movie.poster?.absoluteString ?? "", sizeWidth: 120, sizeHeight: 200, save: save)
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
