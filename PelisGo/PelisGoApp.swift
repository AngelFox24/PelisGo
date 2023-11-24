//
//  PelisGoApp.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

@main
struct PelisGoApp: App {
    let mainContext = PersistenceController.shared.viewContext
    var body: some Scene {
        WindowGroup {
            //Managers
            let localMovieManager = LocalMovieManager(mainContext: mainContext)
            let remoteMovieManager = RemoteMovieManager()
            //Repositories
            let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
            //ViewModel
            let logInViewModel = LogInViewModel()
            let homeViewModel = HomeViewModel(movieRepository: movieRepository)
            let detailViewModel = DetailViewModel(movieRepository: movieRepository)
            let navManager = NavManager()
            ContentView()
                .environmentObject(logInViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(detailViewModel)
                .environmentObject(navManager)
        }
    }
}
