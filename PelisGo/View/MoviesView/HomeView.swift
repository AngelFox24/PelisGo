//
//  MoviesListView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var detailViewModel: DetailViewModel
    @EnvironmentObject var navManager: NavManager
    @AppStorage("homeViewColumns") var hasHomeViewColumns: Int?
    private let spacingI: CGFloat = 10
    private var gridItem = GridItem(.flexible(), spacing: 1)
    private var homeViewCols: [GridItem] = []
    init() {
        gridItem = GridItem(.flexible(), spacing: spacingI)
        let screenWidth: Double = UIScreen.main.bounds.size.width
        let cardViewWidth = 120.0
        let colsD = screenWidth / (cardViewWidth + Double(spacingI))
        print("Columnas Double : \(colsD)")
        let colsI = Int(colsD.rounded())
        print("Columnas Int : \(colsI)")
        hasHomeViewColumns = colsI
        var colsTemp = colsI
        while colsTemp >= 1 {
            homeViewCols.append(gridItem)
            colsTemp = colsTemp - 1
        }
        print("Cols Count : \(homeViewCols.count)")
    }
    var body: some View {
        VStack(spacing: 0) {
            HomeTopBarView()
            if homeViewModel.moviesList.count == 0 {
                VStack {
                    Button(action: {
                        homeViewModel.fetchMovies()
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
            } else {
                VStack(content: {
                    List {
                        LazyVGrid(columns: homeViewCols, spacing: 1) {
                            ForEach(homeViewModel.moviesList) { movie in
                                MovieCardView(movie: movie, save: false)
                                    .onTapGesture {
                                        detailViewModel.saveCurrentMovie(movie: movie)
                                        navManager.goToMovieDetail()
                                    }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                })
                .navigationDestination(for: NavPathsEnum.self, destination: { view in
                    if view == .movieDetail {
                        MovieDetailView()
                    } else {
                        let _ = print("Sin Ruta")
                    }
                })
            }
        }
        .background(Color(.gray))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let localMovieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        let remoteMovieManager = RemoteMovieManager()
        //Repositories
        let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //ViewModel
        let logInViewModel = LogInViewModel()
        let homeViewModel = HomeViewModel(movieRepository: movieRepository)
        let detailViewModel = DetailViewModel(movieRepository: movieRepository)
        let navManager = NavManager()
        HomeView()
            .environmentObject(logInViewModel)
            .environmentObject(homeViewModel)
            .environmentObject(detailViewModel)
            .environmentObject(navManager)
    }
}
