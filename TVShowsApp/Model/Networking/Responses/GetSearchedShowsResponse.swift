//
//  GetSearchedShowsResponse.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//


import Foundation


typealias GetSearchedShowsResponse = [GetSearchedShowsResponseContent]

struct GetSearchedShowsResponseContent: Codable {
    let content: Shows
    enum CodingKeys: String, CodingKey {
        case content = "show"
    }
    func toSeries() -> Shows {
        Shows.fromContent(series: self.content)
    }
    static func arrayOfSeries(responses: [GetSearchedShowsResponseContent]) -> [Shows] {
        var newArrayOfSeries = [Shows]()
        for response in responses {
            let newSeries = response.toSeries()
            newArrayOfSeries.append(newSeries)
        }
        return newArrayOfSeries
    }
}
