//
//  Episode.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//
import Foundation


struct Episode: Codable {
    
    let id: Int
    let name: String
    let season, number: Int
    let image: Image?
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case id, name, season, number, image, summary
    }
}
