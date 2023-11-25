//
//  ContentView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var logInViewModel: LogInViewModel
    @EnvironmentObject var navManager: NavManager
    var body: some View {
        NavigationStack(path: $navManager.navPaths) {
            if logInViewModel.logInStatus == .success {
                HomeView()
            } else {
                LogInView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let localMovieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        let remoteMovieManager = RemoteMovieManager()
        //Repositories
        let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //UseCases
        let logInUseCase = LogInInteractor()
        let getMoviesUseCase = GetMovieInteractor(movieRepository: movieRepository)
        let saveMovieUseCase = SaveMovieInteractor(movieRepository: movieRepository)
        let clearAllMoviesUseCase = ClearAllMoviesInteractor(movieRepository: movieRepository)
        //ViewModel
        let logInViewModel = LogInViewModel(logInUseCase: logInUseCase)
        let homeViewModel = HomeViewModel(getMoviesUseCase: getMoviesUseCase, clearAllMoviesUseCase: clearAllMoviesUseCase)
        let detailViewModel = DetailViewModel(saveMovieUseCase: saveMovieUseCase)
        let navManager = NavManager()
        ContentView()
            .environmentObject(logInViewModel)
            .environmentObject(homeViewModel)
            .environmentObject(detailViewModel)
            .environmentObject(navManager)
    }
}
