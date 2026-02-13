//
//  showDetailsViewModel.swift
//  movieboy
//
//  Created by Bendegúz Timár on 12.10.23.
//

import Foundation
import OSLog

@Observable
/// Viewmodel for the detailView
class DetailsViewModel {
    /// media of which the details are shown
    let media: Media
    
    /// media similar to the actual media
    var similarMedia: [Media] = []
    
    init(media: Media) {
        self.media = media
    }
    
    /// Update the similarMedia list, which updates the listView of similar media in DetailsPage
    func fetchSimilarShows() async {
        let type = media.type == MediaType.Movie ? "movie" : "tv"
        do {
            similarMedia = try await MediaService.fetchSimilarMedia(type: type, id: media.id)
        } catch {
            Logger().error("\(error.localizedDescription)")
        }
    }
    
    /// short-hand for generating the proper release yeart text value
    var releaseDateText: String? {
        if media.releaseDate != nil {
            if let temp = media.releaseDate?.split(separator: "-")[0] {
                return "Release year: \(String(temp))"
            }
        }
        
        if media.firstAirDate != nil {
            if let temp = media.firstAirDate?.split(separator: "-")[0] {
                return "First year of air: \(String(temp))"
            }
        }
        
        return nil
    }
}
