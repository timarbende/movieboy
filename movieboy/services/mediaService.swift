//
//  moviesService.swift
//  movieboy
//
//  Created by Bendegúz Timár on 11.10.23.
//

import Foundation

/// Service for handling requests regarding media
class MediaService {
    /// Fetch the first page of the most popular media
    /// - Parameters:
    ///     - type: either "movie" or "tv"
    ///
    /// - Returns: A list of the most popular media
    static func fetchPopularMedia(type: String) async throws -> [Media] {
       return try await fetch(url: "https://api.themoviedb.org/3/\(type)/popular")
    }
    
    /// Fetch similar media based on ID
    ///
    /// - Parameters:
    ///     - type: either "movie" or "tv"
    ///     - id: ID of the media to be used
    ///
    /// - Returns: A list of media that are similar to the one in the parameter
    static func fetchSimilarMedia(type: String, id: Int) async throws -> [Media] {
       return try await fetch(url: "https://api.themoviedb.org/3/\(type)/\(id)/similar")
    }
    
    /// Search for media based on title
    ///
    /// - Parameters:
    ///     - type: either "movie" or "tv"
    ///     - title: parameter to search based on
    ///
    /// - Returns: A list of media that have a match in the title
    static func searchByTitle(type: String, title: String) async throws -> [Media] {
        return try await fetch(url: "https://api.themoviedb.org/3/search/\(type)?query=\(title)&page=1")
    }
    
    /// Fetch media currently being played in cinemas or prioritized by popular streaming services
    ///
    /// - Parameters:
    ///     - type: either "movie" or "tv"
    ///
    /// - Returns: A list of media currently being played
    static func fetchCurrentMedia(type: MediaType) async throws -> [Media] {
        if type == MediaType.Movie {
            return try await fetch(url: "https://api.themoviedb.org/3/movie/now_playing")
        }
        return try await fetch(url: "https://api.themoviedb.org/3/tv/on_the_air")
    }
    
    /// Fetch media from the provided url
    ///
    /// - Parameters:
    ///     - url: url of the location to fetch data from
    ///
    /// - Returns: A list of media
    private static func fetch(url: String) async throws -> [Media] {
        do {
            let (data, _) = try await ApiHandler.fetchData(url: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(TMDBResponse<Media>.self, from: data)
            return response.results
        } catch {
            throw error
        }
    }
}
