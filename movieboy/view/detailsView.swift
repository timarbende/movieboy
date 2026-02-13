//
//  showDetailsView.swift
//  movieboy
//
//  Created by Bendegúz Timár on 12.10.23.
//

import SwiftUI

/// View showing the details of a chosen media. Set the template parameter accordingly
struct DetailsView: View {
    /// favouritesViewModel passed down to enable favouriting
    @Bindable var favouritesViewModel: FavouritesViewModel
    
    @Binding var path: NavigationPath
    
    /// Viewmodel
    let viewModel: DetailsViewModel
    
    init(media: Media, path: Binding<NavigationPath>, favouritesViewModel: FavouritesViewModel) {
        viewModel = DetailsViewModel(media: media)
        self._path = path
        self.favouritesViewModel = favouritesViewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                DetailPoster(media: viewModel.media)
                
                Spacer().frame(height: 10)
                
                Text(viewModel.media.overview ?? "")
                
                if let releaseDateText = viewModel.releaseDateText {
                    Text(releaseDateText)
                }
                
                Text("Original language: \(viewModel.media.originalLanguage ?? "")")
                
                Text("Average rating: \(String(format: "%.1f", viewModel.media.voteAverage ?? ""))")
                
                DisclosureGroup("Similar shows") {
                    VStack {
                        ForEach(viewModel.similarMedia, id: \.id) { media in
                            NavigationListTile(
                                withFavouriteButton: false,
                                media: media,
                                path: $path,
                                favouritesViewModel: favouritesViewModel
                            )
                        }
                    }
                }
            }.padding(16)
        }.task {
            await viewModel.fetchSimilarShows()
        }
        .toolbar {
            Button(
                action: {
                    if favouritesViewModel.isFavourite(id: viewModel.media.id) {
                        favouritesViewModel.removeFromFavourites(media: viewModel.media)
                    } else {
                        favouritesViewModel.addToFavourites(media: viewModel.media)
                    }
                }, label: {
                    Image(
                        systemName: favouritesViewModel.isFavourite(id: viewModel.media.id) ?
                        "star.fill"
                        : "star")
                    .resizable()
                    .foregroundColor(Color(red: 0.9, green: 0.57, blue: 0.3))
                }
            )
        }
        .navigationTitle(viewModel.media.title ?? viewModel.media.name ?? "unknown media")
    }
}
