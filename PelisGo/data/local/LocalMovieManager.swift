//
//  LocalMovieManager.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation
import CoreData

protocol MovieManager {
    func addMovie(movie: Movie) -> Bool //C
    func getListMovies() -> [Movie] //R
    //func updateMovie(movie: Movie) //U
    func deleteMovie(movie: Movie) -> Bool //D
}

class LocalMovieManager: MovieManager {
    let mainContext: NSManagedObjectContext
    init(mainContext: NSManagedObjectContext) {
        self.mainContext = mainContext
    }
    func saveData() {
        do {
            try self.mainContext.save()
        } catch {
            print("Error saving in LocalMovieManager: \(error)")
        }
    }
    func rollback() {
        self.mainContext.rollback()
    }
    //C - Create
    func addMovie(movie: Movie) -> Bool {
        return true
    }
    //R - Read
    func getListMovies() -> [Movie] {
        var moviesList: [Movie] = []
        return moviesList
    }
    //U - Update
    //D - Delete
    func deleteMovie(movie: Movie) -> Bool {
        return true
    }
}
