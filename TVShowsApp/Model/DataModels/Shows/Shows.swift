//
//  ViewModelDelegate.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation

struct Shows: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let image: Image?
    let summary: String?
    let updated: Int?
    let genres: [String]?
    
        static func fromContent(series: Shows) -> Shows {
            let newShow = Shows(id: series.id, url: series.url, name: series.name, runtime: series.runtime, averageRuntime: series.averageRuntime, premiered: series.premiered, ended: series.ended, officialSite: series.officialSite, schedule: series.schedule, rating: series.rating, weight: series.weight, image: series.image, summary: series.summary, updated: series.updated,genres: series.genres)
            return newShow
        }

}


// MARK: - Image
struct Image: Codable {
    let medium, original: String?
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String?
    let days: [String]?
}


