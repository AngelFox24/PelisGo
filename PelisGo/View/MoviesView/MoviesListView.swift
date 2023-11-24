//
//  MoviesListView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct MoviesListView: View {
    @EnvironmentObject var moviesListViewModel: MoviesListViewModel
    var body: some View {
        VStack(spacing: 0) {
            /*
            if moviesListViewModel.moviesList.count == 0 {
                VStack {
                    Button(action: {
                        //selectedTab = .plus
                    }, label: {
                        VStack(content: {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.custom("Artifika-Regular", size: 90))
                                .foregroundColor(.blue)
                            Text("Recargar.")
                                .foregroundColor(.blue)
                                .padding(.horizontal, 20)
                                .font(.custom("Artifika-Regular", size: 18))
                        })
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                */
            //} else {
                List {
                    ForEach(moviesListViewModel.moviesList) { movie in
                        MovieCardView(movie: movie)
                    }
                }
                .listStyle(PlainListStyle())
            //}
        }
        .background(Color(.gray))
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let localMovieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        let remoteMovieManager = RemoteMovieManager()
        //Repositories
        let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //ViewModel
        let moviesListViewModel = MoviesListViewModel(movieRepository: movieRepository)
        MoviesListView()
            .environmentObject(moviesListViewModel)
    }
}
