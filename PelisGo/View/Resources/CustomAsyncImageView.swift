//
//  CustomAsyncImageView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct CustomAsyncImageView: View {
    let id: UUID
    let urlProducto: String
    let sizeWidth: CGFloat
    let sizeHeight: CGFloat
    @ObservedObject var imageProductNetwork = ImageProductNetworkViewModel()
    init(id: UUID, urlProducto: String, sizeWidth: CGFloat, sizeHeight: CGFloat, imageProductNetwork: ImageProductNetworkViewModel = ImageProductNetworkViewModel()) {
        self.id = id
        self.urlProducto = urlProducto
        self.sizeWidth = sizeWidth
        self.sizeHeight = sizeHeight
        self.imageProductNetwork = imageProductNetwork
        imageProductNetwork.getImage(id: id, url: (((URL(string: urlProducto ) ?? URL(string: "https://falabella.scene7.com/is/image/FalabellaPE/gsc_117581885_1813935_1?wid=1500&hei=1500&qlt=70"))!)))
        print("Se cargo la imagen en Init")
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
                Image("ProductoSinNombre")
                    .resizable()
                    .frame(width: sizeWidth, height: sizeHeight)
                    .cornerRadius(15.0)
            }
        }
    }
}

#Preview {
    CustomAsyncImageView(id: UUID(uuidString: "3062F3B7-14C7-4314-B342-1EC912EBD925") ?? UUID(), urlProducto: "https://image.tmdb.org/t/p/w500/aTvePCU7exLepwg5hWySjwxojQK.jpg", sizeWidth: 100, sizeHeight: 100)
}
