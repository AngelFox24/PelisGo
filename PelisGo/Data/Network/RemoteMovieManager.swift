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
    func getListMovies(page: Int, completion: @escaping (Result<[Movie], APIError>) -> Void)
}
final class RemoteMovieManager: ReMovieManager {
    static let apiKey = "55a91965afe6277c90737d0bf3d555f5"
    func getListMovies(page: Int, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        
        guard let apiUrl = URL(string: "https://api.themoviedb.org/3/movie/upcoming?page=\(page)&api_key=\(RemoteMovieManager.apiKey)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            // Verificar si se recibieron datos
            guard let data = data else {
                completion(.failure(.networkError(NSError(domain: "", code: 0, userInfo: nil))))
                return
            }
            
            do {
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                let movies = trendingResults.results
                completion(.success(movies))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}
