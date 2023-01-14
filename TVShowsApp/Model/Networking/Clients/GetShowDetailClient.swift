//
//  GetSeriesDetailClient.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation


struct GetShowDetailClient: APINetworkingClient {
    
    static func getEpisodes(showID: Int) async -> (GetShowDetailResponse?, LocalizedError?) {
        let endpoint = GetEpisodesEndpoint(showID: showID)
        let result = await self.sendRequest(endpoint: endpoint, responseType: GetShowDetailResponse.self)
        
        switch result {
            case .success(let seriesResponse):
                return (seriesResponse, nil)
            case .failure(let requestError):
                return (nil, requestError)
        }
    }
}
