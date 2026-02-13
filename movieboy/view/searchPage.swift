//
//  searchResultsPage.swift
//  movieboy
//
//  Created by Bendegúz Timár on 16.10.23.
//

import SwiftUI
import SwiftUIX

struct SearchPage: View {
    /// favouritesViewModel passed down to enable favouriting
    @Bindable var favouritesViewModel: FavouritesViewModel
    
    @Binding var path: NavigationPath
    
    /// Viewmodel
    @State var viewModel = SearchPageViewModel(type: MediaType.Movie)
    
    init(mediaType: MediaType, favouritesViewModel: FavouritesViewModel, path: Binding<NavigationPath>) {
        self.favouritesViewModel = favouritesViewModel
        _path = path
        viewModel.mediaType = mediaType
    }
    
    var body: some View {
        VStack {
            List {
                IsSearchingObserver { _, newValue in
                    if !newValue {
                        viewModel.result = []
                    }
                }
                ForEach(viewModel.result, id: \.id) { media in
                    NavigationListTile(
                        withFavouriteButton: true,
                        media: media,
                        path: $path,
                        favouritesViewModel: favouritesViewModel
                    )
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .onSubmit(of: .search) {
                Task {
                    await viewModel.search()
                }
            }
        }.navigationTitle("Search")
    }
}

/// small component used to subscribe to the changing of the isSearching environment variable
struct IsSearchingObserver: View {
    @Environment(\.isSearching) var isSearching
    let onIsSearchingChange: (Bool, Bool) -> Void
    
    var body: some View {
        EmptyView()
            .onChange(of: isSearching) { oldValue, newValue in
                self.onIsSearchingChange(oldValue, newValue)
            }
    }
}
