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
            if moviesListViewModel.moviesList.count == 0 {
                VStack {
                    Image("groundhog_finding")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                    Text("Error al cargar las Películas.")
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .font(.custom("Artifika-Regular", size: 18))
                    /*
                    Button(action: {
                        selectedTab = .plus
                    }, label: {
                        CustomButton1(text: "Agregar")
                    })
                     */
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(moviesListViewModel.moviesList) { movie in
                        MovieCardView(movie: movie)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(Color(.gray))
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        //Managers
        let movieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        //Repositories
        let movieRepository = MovieRepositoryImpl(manager: movieManager)
        //ViewModel
        let moviesListViewModel = MoviesListViewModel(movieRepository: movieRepository)
        MoviesListView()
            .environmentObject(moviesListViewModel)
    }
}
