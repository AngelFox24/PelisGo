//
//  Dependencies.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import Foundation
import CoreData

struct Dependencies {
    let mainContext: NSManagedObjectContext
    let localMovieManager: LocalMovieManager
    let remoteMovieManager: RemoteMovieManager
    //Repositories
    let movieRepository: MovieRepositoryImpl
    //UseCases
    let logInUseCase: LogInInteractor
    let getMoviesUseCase: GetMovieInteractor
    let saveMovieUseCase: SaveMovieInteractor
    let clearAllMoviesUseCase: ClearAllMoviesInteractor
    //ViewModel
    let logInViewModel: LogInViewModel
    let homeViewModel: HomeViewModel
    let detailViewModel: DetailViewModel
    //Navigation Manager
    let navManager: NavManager
    init() {
        self.mainContext = PersistenceController.shared.viewContext
        self.localMovieManager = LocalMovieManager(mainContext: mainContext)
        self.remoteMovieManager = RemoteMovieManager()
        //Repositories
        self.movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //UseCases
        self.logInUseCase = LogInInteractor()
        self.getMoviesUseCase = GetMovieInteractor(movieRepository: movieRepository)
        self.saveMovieUseCase = SaveMovieInteractor(movieRepository: movieRepository)
        self.clearAllMoviesUseCase = ClearAllMoviesInteractor(movieRepository: movieRepository)
        //ViewModel
        self.logInViewModel = LogInViewModel(logInUseCase: logInUseCase)
        self.homeViewModel = HomeViewModel(getMoviesUseCase: getMoviesUseCase, clearAllMoviesUseCase: clearAllMoviesUseCase)
        self.detailViewModel = DetailViewModel(saveMovieUseCase: saveMovieUseCase)
        //Navigation Manager
        self.navManager = NavManager()
    }
}
