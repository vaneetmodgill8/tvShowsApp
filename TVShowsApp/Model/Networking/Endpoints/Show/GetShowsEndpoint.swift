//
//  GetShowsAPIClient.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//


import Foundation


struct GetShowsEndpoint: Endpoint {
    
    var baseURL: String = Endpoints.tvMazeBaseURL
    var path: String = Endpoints.tvMazeShowsEndpoint
    var parameters: [String : String]?
    var method: HTTPMethods = .get
    var header: [String : String]? = ["Content-Type": "application/json;charset=utf-8"]
    var body: [String : String]?
}
