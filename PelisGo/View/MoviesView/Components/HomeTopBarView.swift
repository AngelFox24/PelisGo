//
//  HomeTopBarView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 24/11/23.
//

import SwiftUI

enum HomeSelection {
    case refresh
    case logOut
    case clearCoreData
    var longDescription: String {
        switch self {
        case .refresh:
            return "Volver a Cargar"
        case .logOut:
            return "Cerrar Sesion"
        case .clearCoreData:
            return "Limpiar Archivos Locales"
        }
    }
    static var allValues: [HomeSelection] {
        return [.logOut, .clearCoreData]
    }}

struct HomeTopBarView: View {
    @EnvironmentObject var logInViewModel: LogInViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var detailViewModel: DetailViewModel
    @EnvironmentObject var navManager: NavManager
    var body: some View {
        HStack {
            Spacer()
            Text("Pelis Go")
            Spacer()
            HStack(content: {
                Menu {
                    Button(role: .none, action: {
                        logInViewModel.logOut()
                    }, label: {
                        HStack(content: {
                            Image(systemName: "arrow.up.circle")
                        })
                        HStack(content: {
                            Text(HomeSelection.logOut.longDescription)
                        })
                    })
                    Button(role: .none, action: {
                        homeViewModel.clearAllData()
                        homeViewModel.fetchMovies()
                    }, label: {
                        HStack(content: {
                            Image(systemName: "trash")
                        })
                        HStack(content: {
                            Text(HomeSelection.clearCoreData.longDescription)
                        })
                    })
                    Button(role: .none, action: {
                        homeViewModel.fetchMovies()
                    }, label: {
                        HStack(content: {
                            Image(systemName: "arrow.circlepath")
                        })
                        HStack(content: {
                            Text(HomeSelection.refresh.longDescription)
                        })
                    })
                } label: {
                    CustomButton2()
                }
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 8)
        .padding(.horizontal, 10)
        .background(Color("color_primary"))
    }
}

struct HomeTopBarView_Previews: PreviewProvider {
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
        HomeTopBarView()
            .environmentObject(logInViewModel)
            .environmentObject(homeViewModel)
            .environmentObject(detailViewModel)
            .environmentObject(navManager)
    }
}
