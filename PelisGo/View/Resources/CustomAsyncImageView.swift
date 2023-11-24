//
//  CustomAsyncImageView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct CustomAsyncImageView: View {
    let id: Int
    let urlProducto: String
    let sizeWidth: CGFloat
    let sizeHeight: CGFloat
    @ObservedObject var imageProductNetwork = ImageProductNetworkViewModel()
    init(id: Int, urlProducto: String, sizeWidth: CGFloat, sizeHeight: CGFloat, imageProductNetwork: ImageProductNetworkViewModel = ImageProductNetworkViewModel()) {
        self.id = id
        self.urlProducto = urlProducto
        self.sizeWidth = sizeWidth
        self.sizeHeight = sizeHeight
        self.imageProductNetwork = imageProductNetwork
        imageProductNetwork.getImage(id: id, url: (((URL(string: urlProducto ) ?? URL(string: "https://falabella.scene7.com/is/image/FalabellaPE/gsc_117581885_1813935_1?wid=1500&hei=1500&qlt=70"))!)))
        print("Se cargo la imagen en Init")
        print("URL: \(urlProducto)")
    }
    var body: some View {
        HStack {
            if let imageC = imageProductNetwork.imageProduct {
                imageC
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: sizeWidth, height: sizeHeight)
                    .cornerRadius(15.0)
            } else {
                //PlaceHolder
                //Image("ProductoSinNombre")
                Color.red
                    //.resizable()
                    .frame(width: sizeWidth, height: sizeHeight)
                    .cornerRadius(15.0)
            }
        }
    }
}

#Preview {
    CustomAsyncImageView(id: 24125, urlProducto: "https://image.tmdb.org/t/p/w500/aTvePCU7exLepwg5hWySjwxojQK.jpg", sizeWidth: 100, sizeHeight: 100)
}
