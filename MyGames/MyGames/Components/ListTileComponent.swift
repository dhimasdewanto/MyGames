//
//  ListTileComponent.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

/// Component tile for [GameItem].
struct ListTileComponent: View {
    var game: GameItem
    var ranking: Int?
    var favorite: FavoriteItem

    var body: some View {
        HStack {
            ZStack(
                alignment: .bottomLeading
            ) {
                WebImage(
                    url: URL(string: game.imageLocation)
                )
                .resizable()
                .scaledToFill()
                .frame(
                    width: 120,
                    height: 100
                )
                .cornerRadius(10)
                .clipped()

                if game.rating > 0 {
                    Text("⭐️ \(String(format: "%.1f", game.rating))")
                        .foregroundColor(.primary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(7)
                        .padding(.all, 7)
                }
            }

            VStack(alignment: .leading) {
                Text(game.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                    .padding(.horizontal, 5)

                Spacer()

                if ranking != nil {
                    Text("Ranking: \(ranking!)")
                        .foregroundColor(.primary)
                        .font(.caption)
                        .padding(.horizontal, 5)
                        .padding(.top, 5)
                }

                Spacer()

                Text(FormatDate.toString(game.releaseDate))
                    .foregroundColor(.primary)
                    .font(.subheadline)
                    .padding(.horizontal, 5)
                    .padding(.top, 5)
            }

            Spacer()

            FavoriteButton(
                favorite: favorite
            )
        }
        .padding()
    }
}
