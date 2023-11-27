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
        
        let dependencies = Dependencies()
        ContentView()
            .environmentObject(dependencies.logInViewModel)
            .environmentObject(dependencies.homeViewModel)
            .environmentObject(dependencies.detailViewModel)
            .environmentObject(dependencies.navManager)
    }
}
