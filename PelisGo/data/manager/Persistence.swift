//
//  Persistence.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    private let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PelisGo")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to initialize data \(error)")
            }
        }
    }
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    var persistContainer: NSPersistentContainer {
        container
    }
}
