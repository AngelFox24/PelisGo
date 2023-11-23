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
            ContentView()
        }
    }
}
