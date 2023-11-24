//
//  TrendingResults.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
