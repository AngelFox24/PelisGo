//
//  CustomAsyncImageView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct CustomAsyncImageView: View {
    let id: String
    let urlProducto: String
    let sizeWidth: CGFloat
    let sizeHeight: CGFloat
    let contendMode: ContentMode
    @ObservedObject var imageProductNetwork = ImageProductNetworkViewModel()
    init(id: String, urlProducto: String, sizeWidth: CGFloat, sizeHeight: CGFloat, imageProductNetwork: ImageProductNetworkViewModel = ImageProductNetworkViewModel(), contendMode: ContentMode = .fit) {
        self.id = id
        self.urlProducto = urlProducto
        self.sizeWidth = sizeWidth
        self.sizeHeight = sizeHeight
        self.imageProductNetwork = imageProductNetwork
        self.contendMode = contendMode
        imageProductNetwork.getImage(id: id, url: (((URL(string: urlProducto ) ?? URL(string: "https://falabella.scene7.com/is/image/FalabellaPE/gsc_117581885_1813935_1?wid=1500&hei=1500&qlt=70"))!)))
        print("Se cargo la imagen en Init")
        print("URL: \(urlProducto)")
    }
    var body: some View {
        HStack {
            if let imageC = imageProductNetwork.imageProduct {
                imageC
                    .resizable()
                    .aspectRatio(contentMode: contendMode)
                    .frame(maxWidth: sizeWidth, minHeight: sizeHeight)
            } else {
                Color.red
                    .frame(width: 120, height: 200)
            }
        }
    }
}

#Preview {
    VStack{
        CustomAsyncImageView(id: "24125", urlProducto: "https://image.tmdb.org/t/p/w500/aTvePCU7exLepwg5hWySjwxojQK.jpg", sizeWidth: 100, sizeHeight: 100)
    }
}
