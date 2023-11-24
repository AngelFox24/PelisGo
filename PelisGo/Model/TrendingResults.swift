//
//  TrendingResults.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

struct TrendingResults: Decodable {
    let dates: Dates
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
struct Dates: Codable {
    let maximum, minimum: String
}
