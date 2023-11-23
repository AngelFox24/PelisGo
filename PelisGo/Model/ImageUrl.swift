//
//  ImageUrl.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

struct ImageUrl: Identifiable {
    var id: UUID
    var imageUrl: String
    static func getDummyImage() -> ImageUrl {
        return ImageUrl(id: UUID(uuidString: "IM001") ?? UUID(), imageUrl: "https://image.tmdb.org/t/p/w500/aTvePCU7exLepwg5hWySjwxojQK.jpg")
    }
}
