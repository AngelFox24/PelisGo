//
//  MovieDetailView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var detailViewModel: DetailViewModel
    let movie = Movie.preview
    var body: some View {
        VStack(spacing: 0, content: {
            if let movie = detailViewModel.movie {
                DetailTopBarView(tittle: movie.title)
            } else {
                DetailTopBarView(tittle: movie.title)
            }
            MovieDetailViewScroll()
        })
        .background(Color("color_background"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dependencies = Dependencies()
        MovieDetailView()
            .environmentObject(dependencies.logInViewModel)
            .environmentObject(dependencies.homeViewModel)
            .environmentObject(dependencies.detailViewModel)
            .environmentObject(dependencies.navManager)
    }
}

struct MovieDetailViewScroll: View {
    @EnvironmentObject var detailViewModel: DetailViewModel
    @Namespace var nameSpace
    var body: some View {
        ScrollView(content: {
            let overviewD = NSLocalizedString("Description", comment: "Description")
            let movie: Movie = detailViewModel.movie ?? Movie.preview
            VStack(spacing: 0, content: {
                HStack(content: {
                    CustomAsyncImageView(id: movie.id.description + "_backdrop_path", urlProducto: movie.backdropURL?.absoluteString ?? "", sizeWidth: UIScreen.main.bounds.width, sizeHeight: 210, contendMode: .fill)
                })
                HStack(content: {
                    Spacer()
                    VoteView(voteAverage: movie.vote_average)
                    Spacer()
                    if let date = movie.release_date_converted {
                        Image(systemName: "calendar")
                        Text(String(date.getDateFormat(dateFormat: "dd/MM/yyyy") ))
                        Spacer()
                    }
                })
                .foregroundColor(Color("color_accent"))
                .font(.custom("Artifika-Regular", size: 25))
                .padding(.top, 20)
                HStack(spacing: 5, content: {
                    CustomAsyncImageView(id: movie.id.description + "_poster_path", urlProducto: movie.poster?.absoluteString ?? "", sizeWidth: 120, sizeHeight: 200, contendMode: .fill)
                    VStack(content: {
                        Text(overviewD)
                            .font(.custom("Artifika-Regular", size: 24))
                        Text(movie.overview)
                            .multilineTextAlignment(.center)
                            .font(.custom("Artifika-Regular", size: 20))
                            .padding(.horizontal, 15)
                            .padding(.top, 15)
                    })
                })
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .padding(.horizontal, 10)
            })
        })
    }
}
