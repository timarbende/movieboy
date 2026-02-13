//
//  apiHandler.swift
//  movieboy
//
//  Created by Bendegúz Timár on 11.10.23.
//

import Foundation

/// Common point for API requests, handles authentication header
class ApiHandler {
    /// Make a GET request to the API
    ///
    /// - Parameters:
    ///     - url: url of the API endpoint as string
    ///
    /// - Returns: A tuple of (Data and URLResponse). Both contain the request response data
    static func fetchData(url: String) async throws -> (Data, URLResponse) {
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer \(Constants.apiKey)"
        ]
        
        do {
            guard let url = URL(string: url) else {
                throw URLError(.cannotLoadFromNetwork)
            }

            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            return try await URLSession.shared.data(for: request)
        } catch {
            throw error
        }
    }
}
