//
//  ModelMapper.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation
import CoreData

extension Movie {
    func toMovieEntity(context: NSManagedObjectContext) -> CD_Movie? {
        let filterAtt = NSPredicate(format: "id == %@", id.description)
        let request: NSFetchRequest<CD_Movie> = CD_Movie.fetchRequest()
        request.predicate = filterAtt
        do {
            let movieEntity = try context.fetch(request).first
            return movieEntity
        } catch let error {
            print("Error fetching. \(error)")
            return nil
        }
    }
}

extension CD_Movie {
    func toMovie() -> Movie {
        return Movie(adult: adult,
                     id: Int(id),
                     poster_path: poster_path,
                     title:  title ?? "",
                     overview: overview ?? "",
                     vote_average: vote_average,
                     backdrop_path: backdrop_path,
                     release_date: release_date)
    }
}
