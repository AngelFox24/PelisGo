//
//  ContentView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var navManager: NavManager
    var body: some View {
        NavigationStack(path: $navManager.navPaths) {
            //if logInViewModel.logInStatus == .success {
                MoviesListView()
            //} else {
               // WelcomeView(isKeyboardVisible: $isKeyboardVisible)
            //}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let localMovieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        let remoteMovieManager = RemoteMovieManager()
        //Repositories
        let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //ViewModel
        let homeViewModel = HomeViewModel(movieRepository: movieRepository)
        let detailViewModel = DetailViewModel(movieRepository: movieRepository)
        let navManager = NavManager()
        ContentView()
            .environmentObject(homeViewModel)
            .environmentObject(detailViewModel)
            .environmentObject(navManager)
    }
}
