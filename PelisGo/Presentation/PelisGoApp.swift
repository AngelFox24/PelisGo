//
//  PelisGoApp.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

@main
struct PelisGoApp: App {
    var body: some Scene {
        WindowGroup {
            let dependencies = Dependencies()
            // Content View with Dependency Injection
            ContentView()
                .environmentObject(dependencies.logInViewModel)
                .environmentObject(dependencies.homeViewModel)
                .environmentObject(dependencies.detailViewModel)
                .environmentObject(dependencies.navManager)
        }
    }
}
