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
        let localMovieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        let remoteMovieManager = RemoteMovieManager()
        //Repositories
        let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //ViewModel
        let homeViewModel = HomeViewModel(movieRepository: movieRepository)
        let detailViewModel = DetailViewModel(movieRepository: movieRepository)
        MovieDetailView()
            .environmentObject(homeViewModel)
            .environmentObject(detailViewModel)
    }
}

struct MovieDetailViewScroll: View {
    @EnvironmentObject var detailViewModel: DetailViewModel
    let movie = Movie.preview
    
    var body: some View {
        ScrollView(content: {
            if let movie = detailViewModel.movie {
                VStack(spacing: 0, content: {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                        CustomAsyncImageView(id: movie.id.description + "_backdrop_path", urlProducto: movie.backdropURL?.absoluteString ?? "", sizeWidth: .infinity, sizeHeight: 210, contendMode: .fill)
                        HStack(content: {
                            Spacer()
                            CustomAsyncImageView(id: movie.id.description + "_poster_path", urlProducto: movie.poster?.absoluteString ?? "", sizeWidth: 120, sizeHeight: 200, contendMode: .fit)
                        })
                        .frame(maxWidth: .infinity)
                    })
                    HStack(content: {
                        Spacer()
                        Text(String(movie.vote_average))
                        Spacer()
                        if let date = movie.release_date_converted {
                            Text(date.getDateFormat(dateFormat: "dd/MM/yyyy"))
                        }
                        Spacer()
                    })
                    .padding(.top, 20)
                    Text(movie.overview)
                })
            } else {
                VStack(spacing: 0, content: {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                        CustomAsyncImageView(id: movie.id.description + "_backdrop_path", urlProducto: movie.backdropURL?.absoluteString ?? "", sizeWidth: .infinity, sizeHeight: 210, contendMode: .fill)
                        HStack(content: {
                            Spacer()
                            CustomAsyncImageView(id: movie.id.description + "_poster_path", urlProducto: movie.poster?.absoluteString ?? "", sizeWidth: 120, sizeHeight: 200, contendMode: .fit)
                        })
                        .frame(maxWidth: .infinity)
                    })
                    HStack(content: {
                        Spacer()
                        Text(String(movie.vote_average))
                        Spacer()
                        if let date = movie.release_date_converted {
                            Text(date.getDateFormat(dateFormat: "dd/MM/yyyy"))
                        }
                        Spacer()
                    })
                    .padding(.top, 20)
                    Text(movie.overview)
                })
            }
        })
        //.padding(.horizontal, 10)
    }
}
