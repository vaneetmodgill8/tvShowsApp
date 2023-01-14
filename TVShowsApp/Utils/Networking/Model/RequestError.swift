//
//  RequestError.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import Foundation


enum RequestError: LocalizedError {
    
    case cantDecode
    case invalidURL
    case notFound
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
        
    
    var errorDescription: String? {
        switch self {
        case .cantDecode:
            return "Decoding Error"
        case .unauthorized:
            return "Unauthorized Error"
        default:
            return "Unknown"
        }
    }
}
