//
//  moviesListResponses.swift
//  movieboy
//
//  Created by Bendegúz Timár on 11.10.23.
//

import Foundation

/// Template model class for storing the response of most requests made to the API. Response result are of type T
struct TMDBResponse<T: Codable> : Codable {
    /// Current page of the response
    var page: Int
    
    /// Result on the current page of the response
    var results: [T]
    
    /// Total pages available from the API endpoint
    var totalPages: Int
    
    /// Total results available from the API endpoint
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
