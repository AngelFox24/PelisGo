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
    let save: Bool
    @State private var isLoading = false
    @ObservedObject var imageProductNetwork = ImageProductNetworkViewModel()
    init(id: String, urlProducto: String, sizeWidth: CGFloat, sizeHeight: CGFloat, imageProductNetwork: ImageProductNetworkViewModel = ImageProductNetworkViewModel(), contendMode: ContentMode = .fit, save: Bool = true) {
        self.id = id
        self.urlProducto = urlProducto
        self.sizeWidth = sizeWidth
        self.sizeHeight = sizeHeight
        self.imageProductNetwork = imageProductNetwork
        self.contendMode = contendMode
        self.save = save
        imageProductNetwork.getImage(id: id, url: (((URL(string: urlProducto ) ?? URL(string: "https://falabella.scene7.com/is/image/FalabellaPE/gsc_117581885_1813935_1?wid=1500&hei=1500&qlt=70"))!)), save: save)
        print("Se cargo la imagen en Init")
        print("URL: \(urlProducto)")
    }
    var body: some View {
        HStack {
            if let imageC = imageProductNetwork.imageProduct {
                imageC
                    .resizable()
                    .aspectRatio(contentMode: contendMode)
                    .frame(maxWidth: sizeWidth, maxHeight: sizeHeight)
                    .cornerRadius(15)
            } else {
                Color.gray
                    .opacity(0.3)
                    .frame(width: sizeWidth, height: sizeHeight)
                    .cornerRadius(15)
                    .loadingAnimation(width: sizeWidth, height: sizeHeight)
            }
        }
    }
}

extension View {
    func loadingAnimation(width: CGFloat, height: CGFloat) -> some View {
        modifier(LoadingAnimationModifier(sizeWidth: width, sizeHeight: height))
    }
}

struct LoadingAnimationModifier: ViewModifier {
    @State private var animatedIsLoading = false
    let sizeWidth: CGFloat
    let sizeHeight: CGFloat
    var isLoading: Bool {
        animatedIsLoading
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 6)
                    .foregroundColor(Color("color_accent"))
                    .frame(width: isLoading ? sizeWidth : 0, height: isLoading ? sizeHeight : 0)
            )
            .onAppear() {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: true)) {
                    animatedIsLoading.toggle()
                }
            }
    }
}

#Preview {
    VStack{
        CustomAsyncImageView(id: "24125s", urlProducto: "shttps://image.tmdb.org/t/p/w500/aTvePCU7exLepwg5hWySjwxojQK.jpg", sizeWidth: 100, sizeHeight: 100)
    }
}
