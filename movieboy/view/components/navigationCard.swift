//
//  navigationCard.swift
//  movieboy
//
//  Created by Bendegúz Timár on 16.10.23.
//

import SwiftUI

/// Large card component for showing a media's poster and title, and navigating on user click to the media's detailView
struct NavigationCard: View {
    @Binding var path: NavigationPath
    let media: Media
    
    var body: some View {
        Button {
            path.append(media)
        } label: {
            ZStack {
                AsyncImage(url: URL(string: "\(Configuration.instance.images?.secureBaseUrl ?? "oh how i wish to be back on the sea")\(Configuration.instance.images?.posterSizes[(Configuration.instance.images?.posterSizes.count ?? 3) - 3] ?? "but alas, i am stuck here with my wife")/\(media.posterPath ?? "")")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(
                                width: UIScreen.main.bounds.width - 60,
                                height: UIScreen.main.bounds.height / 4.0 - 10
                            )
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .cornerRadius(30)
                    default:
                        Text("Failed to load")
                    }
                }
            }
            .overlay(alignment: .bottomTrailing) {
                Text(media.title ?? media.name ?? "Unknown media")
                    .font(Font.custom("Blockletter", size: 30))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                    .padding(10)
                    .background(.white.opacity(0.9))
                    .padding(4)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .frame(height: UIScreen.main.bounds.size.height / 4.0 - 10)
        }
    }
}
