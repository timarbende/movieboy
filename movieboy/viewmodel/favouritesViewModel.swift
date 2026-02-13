//
//  favouritesViewModel.swift
//  movieboy
//
//  Created by Bendegúz Timár on 13.10.23.
//

import Foundation

@Observable
/// Viewmodel for the favouritesPage
class FavouritesViewModel {
    /// dictionary to store favourited media based on id
    var _favourites: [Int: Media] = [:]
    
    /// short-hand for accessing only the actual media stored as favourites, either the whole list or the ones correct for the searchTerm
    var favourites: [Media] {
        if searchTerm.isEmpty {
         return Array(_favourites.values)
        }
        return Array(_favourites.values.filter { media in
            if searchTerm.isEmpty {
                return true
            }
            
            return media.title?.localizedCaseInsensitiveContains(searchTerm)
            ?? media.name?.localizedCaseInsensitiveContains(searchTerm)
            ?? false
        })
    }
    
    /// term to be search based on
    var searchTerm = ""
    
    /// Add a media to the favourites
    /// - Parameters:
    ///     - media: the media to be favourited
    func addToFavourites(media: Media) {
        _favourites[media.id] = media
    }
    
    /// Remove a media from the favourites
    /// - Parameters:
    ///     - media: the media to be removed
    func removeFromFavourites(media: Media) {
        _favourites.removeValue(forKey: media.id)
    }
    
    /// Check if a media is favourited
    /// - Parameters:
    ///     - id: id of the media
    /// - Returns: true if the media is favourited, false if not
    func isFavourite(id: Int) -> Bool {
        _favourites[id] != nil
    }
}
