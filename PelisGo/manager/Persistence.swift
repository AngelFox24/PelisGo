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
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    var persistContainer: NSPersistentContainer {
        persistentContainer
    }
}
