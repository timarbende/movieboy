//
//  media.swift
//  movieboy
//
//  Created by Bendegúz Timár on 12.10.23.
//

import Foundation

/// model class for representing Media (Movies or Shows)
struct Media: Hashable, Codable {
    /// path for accessing the poster of the media
    var posterPath: String?
    
    /// title of the movie (equals to name when the MediaType is .Show)
    var title: String?
    
    /// icon path used as placeholder while the poster of the media loads
    var placeHolderIcon: String = "film"
    
    /// overview of the media
    var overview: String?
    
    /// ID of the media
    var id: Int
    
    /// release date of the media
    var releaseDate: String?
    
    /// original language of the media
    var originalLanguage: String?
    
    /// average vote score of the media
    var voteAverage: Double?
    
    // This boolean must be optional because of how the API works
    // swiftlint:disable discouraged_optional_boolean
    /// whether the movie is for adults only
    var adult: Bool?
    
    /// first air date of shows
    var firstAirDate: String?
    
    /// name of the show (equals to title when the MediaType is .Movie)
    var name: String?
    
    /// array containing genre ids of the genres of the media
    var genreIds: [Int] = []
    
    /// type of the media
    var type: MediaType {
        title != nil ? MediaType.Movie : MediaType.Show
    }
    
    init(id: Int) {
        self.id = id
    }
    
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case overview
        case id
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
        case adult
        case firstAirDate = "first_air_date"
        case name
        case genreIds = "genre_ids"
    }
}

enum MediaType {
    case Movie
    case Show
}
