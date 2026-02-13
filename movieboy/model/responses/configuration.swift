//
//  configurationResponse.swift
//  movieboy
//
//  Created by Bendegúz Timár on 11.10.23.
//

import Foundation

/// Model class for storing API configuration information
public class Configuration : Codable {
    var images: ImageConfiguration?
    
    private static var _instance = Configuration()
    static var instance: Configuration {
            _instance
    }
}

/// Model class for storing configuration of image handling on the API
struct ImageConfiguration : Codable {
    /// HTTP URL domain of the image API
    var baseUrl: String
    
    /// HTTPS URL domain of the image API
    var secureBaseUrl: String
    
    /// possible size categories for backdrop
    var backdropSizes: [String]
    
    /// possible size categories for logos
    var logoSizes: [String]
    
    /// possible size categories for posters
    var posterSizes: [String]
    
    enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
    }
}
