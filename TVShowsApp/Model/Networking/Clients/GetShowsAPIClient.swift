//
//  GetShowsAPIClient.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation


struct GetShowsAPIClient: APINetworkingClient {
    
    static func getShows() async -> (GetShowsResponse?, LocalizedError?) {
        let endpoint = GetShowsEndpoint()
        let result = await self.sendRequest(endpoint: endpoint, responseType: GetShowsResponse.self)
        switch result {
            case .success(let seriesResponse):
                return (seriesResponse, nil)
            case .failure(let requestError):
                return (nil, requestError)
        }
    }
    
    static func getSearchedShows(name: String? = nil) async -> (GetSearchedShowsResponse?, LocalizedError?) {
        var endpoint: Endpoint
        guard let nonOptName = name, !nonOptName.isEmpty else {
            return (nil, nil)
        }
        let parameters = ["q" : nonOptName]
        endpoint = GetSearchShowsEndpoint(parameters: parameters)
        let result = await self.sendRequest(endpoint: endpoint, responseType: GetSearchedShowsResponse.self)
        switch result {
            case .success(let searchedSeriesResponse):
                return (searchedSeriesResponse, nil)
            case .failure(let requestError):
                return (nil, requestError)
        }
    }
}
