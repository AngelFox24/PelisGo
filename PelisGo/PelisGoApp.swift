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
            let movieManager = LocalMovieManager(mainContext: mainContext)
            //Repositories
            let movieRepository = MovieRepositoryImpl(manager: movieManager)
            //ViewModel
            let moviesListViewModel = MoviesListViewModel(movieRepository: movieRepository)
            ContentView()
                .environmentObject(moviesListViewModel)
        }
    }
}
