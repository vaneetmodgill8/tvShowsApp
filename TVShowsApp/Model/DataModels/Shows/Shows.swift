//
//  ViewModelDelegate.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation


struct Shows: Codable {
    
    let id: Int
    let name: String?
    let genres: [String]?
    let schedule: Schedule?
    let image: Image?
    let summary: String?
    
    
    static func fromContent(series: Shows) -> Shows {
        let newSeries = Shows(id: series.id, name: series.name, genres: series.genres, schedule: series.schedule, image: series.image, summary: series.summary)
        
        return newSeries
    }
}


struct Image: Codable {
    let medium: String
    let original: String
}


struct Schedule: Codable {
    let time: String
    let days: [String]
}
