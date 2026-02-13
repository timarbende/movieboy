//
//  moviesPageViewModel.swift
//  movieboy
//
//  Created by Bendegúz Timár on 11.10.23.
//

import Foundation
import OSLog

@Observable
/// Viewmodel for the popularMediaPage
class PopularsPageViewModel {
    /// list of popular media
    var popularMedia: [Media] = []
    var currentMedia: [Media] = []
    var mediaType = MediaType.Movie
    var currentMediaLoaded = false
    
    /// Update the popularMedia list, which updates the popularMediaPage's listView
    func fetchPopularMedia() async {
        let type = mediaType == MediaType.Movie ? "movie" : "tv"
        do {
            popularMedia = try await MediaService.fetchPopularMedia(type: type)
        } catch {
            Logger().error("\(error.localizedDescription)")
        }
    }
    
    /// Update the currentMedia list, which updates the popularMediaPage's carousel-view
    func fetchCurrentMedia() async {
        do {
            currentMedia = Array(try await MediaService.fetchCurrentMedia(type: mediaType)[0...9])
            currentMediaLoaded = true
        } catch {
            Logger().error("\(error.localizedDescription)")
        }
    }
}
