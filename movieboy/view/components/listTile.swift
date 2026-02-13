//
//  listtile.swift
//  movieboy
//
//  Created by Bendegúz Timár on 12.10.23.
//

import SwiftUI

/// Template tile to be used in lists with an appropriate media
struct ListTile: View {
    /// whether the listTile should have the star-shaped favourite button
    let withFavouriteButton: Bool
    
    /// data of the listTIle
    let data: Media
    
    /// Viewmodel
    @Bindable var favouritesViewModel: FavouritesViewModel
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: "\(Configuration.instance.images?.secureBaseUrl ?? "we are all screwed")\(Configuration.instance.images?.posterSizes[1] ?? "double screwed actually")/\(data.posterPath ?? "")")) { image in
                    image.resizable().frame(width: 32.0, height: 32.0)
                } placeholder: {
                    Image(systemName: data.placeHolderIcon).resizable().frame(width: 32.0, height: 32.0)
            }
            
            Text(data.title ?? data.name ?? "Unknown media")
                .font(.title)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Spacer()
            
            if withFavouriteButton {
                Button(
                    action: {
                        if favouritesViewModel.isFavourite(id: data.id) {
                            favouritesViewModel.removeFromFavourites(media: data)
                        } else {
                            favouritesViewModel.addToFavourites(media: data)
                        }
                    },
                    label: {
                        Image(
                            systemName: favouritesViewModel.isFavourite(id: data.id) ?
                            "star.fill"
                            : "star")
                        .resizable()
                        .foregroundColor(Color(red: 0.9, green: 0.57, blue: 0.3))
                        .frame(width: 20, height: 20)
                    }
                )
            }
        }
    }
}
