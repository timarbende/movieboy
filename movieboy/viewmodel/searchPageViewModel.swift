//
//  searchPageViewModel.swift
//  movieboy
//
//  Created by Bendegúz Timár on 16.10.23.
//

import Foundation
import OSLog

@Observable
/// Viewmodel for the searchPage
class SearchPageViewModel {
    /// type of media (either .Movie or .Show) the searchPage shows
    var mediaType: MediaType
    
    /// term to be searched based on
    var searchTerm: String = ""
    
    /// results of the search
    var result: [Media] = []
    
    init(type: MediaType) {
        self.mediaType = type
    }
    
    /// Initiate a search and set the 'result' array based on the searchTerm
    /// - Parameters:
    ///     - media: the media to be favourited
    func search() async {
        let type = mediaType == MediaType.Movie ? "movie" : "tv"
        do {
            result = try await MediaService.searchByTitle(type: type, title: searchTerm)
        } catch {
            Logger().error("\(error.localizedDescription)")
        }
    }
}
