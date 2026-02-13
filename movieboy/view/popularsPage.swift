//
//  moviesPage.swift
//  movieboy
//
//  Created by Bendegúz Timár on 11.10.23.
//

import SwiftUI

/// Page showing the popular media, which can be either of type Movie or of type Show. Set the template parameter accordingly.
struct PopularsPage: View {
    /// Viewmodel
    @State var viewModel = PopularsPageViewModel()
    @Binding var path: NavigationPath
    
    /// favouritesViewModel passed down to enable favouriting
    var favouritesViewModel: FavouritesViewModel
    
    init(mediaType: MediaType, path: Binding<NavigationPath>, favouritesViewModel: FavouritesViewModel) {
        _path = path
        self.favouritesViewModel = favouritesViewModel
        viewModel.mediaType = mediaType
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .leading) {
                if viewModel.currentMediaLoaded {
                    Text("Currently playing").font(.title)
                    Carousel(childCount: viewModel.currentMedia.count) { index in
                        NavigationCard(
                            path: $path,
                            media: viewModel.currentMedia[index]
                        )
                    }
                    .frame(height: UIScreen.main.bounds.size.height / 4)
                }
                
                Text("Most popular").font(.title)
                
                PopularsList(viewModel: viewModel, path: $path, favouritesViewModel: favouritesViewModel)
            }
            .padding(16)
            .toolbar {
                Button(
                    action: {
                        path.append("")
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    }
                )
            }
            .navigationTitle(viewModel.mediaType == MediaType.Movie ? "Popular movies" : "Popular shows")
        }.task {
            await viewModel.fetchCurrentMedia()
            await viewModel.fetchPopularMedia()
        }
    }
}
