//
//  GetShowDetailResponse.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//

import Foundation


struct GetShowDetailResponse: Codable {
    
    let id: Int
    let name: String
    let genres: [String]
    let schedule: Schedule?
    let image: Image?
    let summary: String
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case id, name, genres, schedule, image, summary
        case embedded = "_embedded"
    }
}


struct Embedded: Codable {
    let episodes: [Episode]
}
