//
//  RemoteMovieManager.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}

protocol ReMovieManager {
    func getListMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
}

class RemoteMovieManager: ReMovieManager {
    static let apiKey = "f46b58478f489737ad5a4651a4b25079"
    func getListMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        // URL de la API
        guard let apiUrl = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(RemoteMovieManager.apiKey)") else {
            completion(.failure(.invalidURL))
            return
        }
        print("URL ok")
        // Crear una tarea de URLSession para obtener los datos de la API
        URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            // Manejar errores de red
            print("Data Task")
            if let error = error {
                completion(.failure(.networkError(error)))
                print("Network error 1")
                return
            }
            
            // Verificar si se recibieron datos
            guard let data = data else {
                completion(.failure(.networkError(NSError(domain: "", code: 0, userInfo: nil))))
                print("Network error 2")
                return
            }
            
            do {
                print("Do etry ok")
                // Decodificar los datos directamente en un array de Movie
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                
                print("trending ok totalP: \(trendingResults.total_pages) and \(trendingResults.results[1].title)")
                let movies = trendingResults.results
                
                print("Decoder ok")
                // Llamar al bloque de finalización con el array de películas
                completion(.success(movies))
            } catch {
                // Manejar errores de decodificación
                print("Desc err")
                completion(.failure(.decodingError(error)))
            }
        }.resume() // Iniciar la tarea de URLSession
    }
}
