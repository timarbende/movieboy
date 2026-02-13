//
//  navigationListTile.swift
//  movieboy
//
//  Created by Bendegúz Timár on 13.10.23.
//

import SwiftUI

/// Expansion on the listTile component, adds navigation on user click to the listTile's media's detailView
struct NavigationListTile: View {
    /// whether or not the listTIle of the navigationListTile should have the star-shaped favourite button
    let withFavouriteButton: Bool
    
    /// data of the navigationListTile
    let media: Media
    
    @Binding var path: NavigationPath
    
    /// favouritesViewModel passed down to enable favouriting
    var favouritesViewModel: FavouritesViewModel
    
    var body: some View {
        Button(
            action: { path.append(media) },
            label: {
                ListTile(
                    withFavouriteButton: withFavouriteButton,
                    data: media,
                    favouritesViewModel: favouritesViewModel
                )
            }
        )
    }
}
