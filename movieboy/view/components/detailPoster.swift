//
//  detailPoster.swift
//  movieboy
//
//  Created by Bendegúz Timár on 12.10.23.
//

import SwiftUI

/// Poster with the media's title
struct DetailPoster: View {
    /// owner media of the poster
    let media: Media
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                AsyncImage(
                    url: URL(string: "\(Configuration.instance.images?.secureBaseUrl ?? "oh how i wish to be back on the sea")\(Configuration.instance.images?.posterSizes[(Configuration.instance.images?.posterSizes.count ?? 2) - 2] ?? "but alas, i am stuck here with my wife")/\(media.posterPath ?? "")")) { image in
                        image
                            .resizable()
                            .frame(height: 300)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        Image(systemName: "film")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Spacer()
            }
        }.overlay(alignment: .bottomTrailing) {
            Text(media.title ?? media.name ?? "Unknown media")
                .font(Font.custom("Blockletter", size: 35))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.black)
                .padding(10)
                .background(.white.opacity(0.9))
                .padding(4)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}
