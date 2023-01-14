//
//  Endpoint.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation

protocol Endpoint {
    
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: String]? { get }
    var method: HTTPMethods { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

struct Endpoints {
    static var tvMazeBaseURL = "https://api.tvmaze.com"
    static var tvMazeShowsEndpoint = "/shows"
    static var tvMazeSearchSeriesEndpoint = "/search/shows"
    static func tvMazeEpisodesEndpoint(showID: Int) -> String {
        return "/shows/\(showID)?embed=episodes"
    }
}
