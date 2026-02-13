//
//  popularsList.swift
//  movieboy
//
//  Created by Bendegúz Timár on 16.10.23.
//

import SwiftUI

/// the list component of the popularsPage separated into its own component because swift-lint rules are amazing and I love them from the depth of my heart
struct PopularsList: View {
    /// Viewmodel
    let viewModel: PopularsPageViewModel
    
    @Binding var path: NavigationPath
    
    /// favouritesViewModel passed down to enable favouriting
    var favouritesViewModel: FavouritesViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.popularMedia, id: \.id) { media in
                    NavigationListTile(
                        withFavouriteButton: true,
                        media: media,
                        path: $path,
                        favouritesViewModel: favouritesViewModel
                    )
                        .listRowInsets(EdgeInsets())
                }
            }
        }.navigationDestination(for: Media.self) { media in
            DetailsView(media: media, path: $path, favouritesViewModel: favouritesViewModel)
        }
        .navigationDestination(for: String.self) { _ in
            SearchPage(
                mediaType: viewModel.mediaType,
                favouritesViewModel: favouritesViewModel,
                path: $path
            )
        }
    }
}
