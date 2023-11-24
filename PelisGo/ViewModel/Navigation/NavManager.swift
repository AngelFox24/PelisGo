//
//  NavManager.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation
import SwiftUI

enum NavPathsEnum {
    case movies
    case movieDetail
}

class NavManager: ObservableObject {
    @Published var navPaths = NavigationPath()
    
    func goToBack() {
        navPaths.removeLast()
    }
    func popToRoot() {
        navPaths = NavigationPath()
    }
    func goToMovies() {
        navPaths.append(NavPathsEnum.movies)
    }
    func goToMovieDetail() {
        navPaths.append(NavPathsEnum.movieDetail)
    }
}
