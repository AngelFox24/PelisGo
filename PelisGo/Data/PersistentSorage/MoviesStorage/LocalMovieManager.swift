//
//  LocalMovieManager.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation
import CoreData

protocol LoMovieManager {
    func addMovie(movie: Movie) -> Bool //C
    func getListMovies(page: Int, pageSize: Int) -> [Movie] //R
    //func updateMovie(movie: Movie) //U
    func clearAllMovies() -> Bool //D
}

class LocalMovieManager: LoMovieManager {
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
        if let movieInContext = movie.toMovieEntity(context: mainContext) { //Existe pelicula, vamos a actualizarlo
            print("Se encontro producto, lo vamos a actualizar")
            movieInContext.adult = movie.adult
            movieInContext.id = Int64(movie.id)
            movieInContext.poster_path = movie.poster_path
            movieInContext.title = movie.title
            movieInContext.overview = movie.overview
            movieInContext.vote_average = movie.vote_average
            movieInContext.backdrop_path = movie.backdrop_path
            movieInContext.release_date = movie.release_date
            saveData()
            return true
        } else {
            //Creamos una nueva pelicula
            print("Se crea nuevo")
            let newMovie = CD_Movie(context: mainContext)
            newMovie.adult = movie.adult
            newMovie.id = Int64(movie.id)
            newMovie.poster_path = movie.poster_path
            newMovie.title = movie.title
            newMovie.overview = movie.overview
            newMovie.vote_average = movie.vote_average
            newMovie.backdrop_path = movie.backdrop_path
            newMovie.release_date = movie.release_date
            saveData()
            return true
        }
    }
    //R - Read
    func getListMovies(page: Int, pageSize: Int) -> [Movie] {
        var moviesEntityList: [CD_Movie] = []
        
        let request: NSFetchRequest<CD_Movie> = CD_Movie.fetchRequest()
        
        // Configurar paginación
        request.fetchLimit = pageSize
        request.fetchOffset = (page - 1) * pageSize
        
        do {
            moviesEntityList = try self.mainContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        return moviesEntityList.compactMap{$0.toMovie()}
    }
    //U - Update
    //D - Delete
    func clearAllMovies() -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CD_Movie")
        let solicitudEliminacion = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.mainContext.execute(solicitudEliminacion)
        } catch let error {
            print("Error eliminando. \(error)")
        }
        saveData()
        return true
    }
}
