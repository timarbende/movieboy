//
//  favouritePage.swift
//  movieboy
//
//  Created by Bendegúz Timár on 13.10.23.
//

import SwiftUI

struct FavouritesPage: View {
    /// Viewmodel
    @Bindable var favouritesViewModel: FavouritesViewModel
    
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationStack(path: $path) {
                List {
                    ForEach(favouritesViewModel.favourites, id: \.id) { media in
                        NavigationLink(value: media) {
                            ListTile(withFavouriteButton: false, data: media, favouritesViewModel: favouritesViewModel)
                        }
                    }
                }.navigationDestination(for: Media.self) { media in
                    DetailsView(media: media, path: $path, favouritesViewModel: favouritesViewModel)
                }
                .navigationTitle("Favourites")
                .searchable(text: $favouritesViewModel.searchTerm)
        }
    }
}
