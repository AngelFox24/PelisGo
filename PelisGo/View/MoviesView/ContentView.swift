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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
