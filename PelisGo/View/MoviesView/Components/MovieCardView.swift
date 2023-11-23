//
//  MovieCardView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct MovieCardView: View {
    var image: ImageUrl
    var body: some View {
        VStack(content: {
            CustomAsyncImageView(id: image.id, urlProducto: image.imageUrl, sizeWidth: 120, sizeHeight: 200)
        })
    }
}

#Preview {
    VStack{
        MovieCardView(image: ImageUrl.getDummyImage())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray)
}