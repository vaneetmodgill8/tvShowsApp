//
//  GetShowsAPIClient.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 14/01/23.
//

import Foundation


struct GetEpisodesEndpoint: Endpoint {
    
    var baseURL: String = Endpoints.tvMazeBaseURL
    var path: String
    var parameters: [String : String]?
    var method: HTTPMethods = .get
    var header: [String : String]? = ["Content-Type": "application/json;charset=utf-8"]
    var body: [String : String]?
    
    
    init(showID: Int) {
        self.path = Endpoints.tvMazeEpisodesEndpoint(showID: showID)
    }
}
