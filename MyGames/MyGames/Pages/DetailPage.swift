//
//  DetailPage.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 12/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

/// Page to show detail game.
struct DetailPage: View {
    var game: GameItem
    @State private var gameDetail: DetailGameItem?
    private let handler = CatalogueHandler()

    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: CoreGame.entity(),
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \CoreGame.gameId,
                ascending: true
            )
        ]
    ) var coreGames: FetchedResults<CoreGame>

    /// Load detail data from API.
    private func loadData() {
        detailGameRepo.getDetailGame(
            gameId: Int(game.gameId) ?? 0,
            onUpdate: { detail in
                self.gameDetail = detail
            }
        )
    }

    /// Get is favorite from core data.
    private func getIsFavorite() -> Bool {
        return handler.getIsFavorite(
            coreGames: coreGames,
            game: game
        )
    }

    /// On click favorite button.
    private func onFavorite() {
        handler.setIsFavorite(
            context: managedObjectContext,
            coreGames: coreGames,
            game: game
        )
    }

    var body: some View {
        Section {
            if gameDetail == nil {
                ProgressView()
            } else {
                let detail = gameDetail!
                ScrollView {
                    VStack {
                        WebImage(
                            url: URL(string: detail.imageLocation)
                        )
                        .resizable()
                        .scaledToFit()

                        Text(detail.name)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                            .padding(.horizontal)

                        MetacriticView(
                            metacritic: detail.metacritic
                        )

                        Text("Release Date:")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                            .padding(.horizontal)

                        Text(
                            FormatDate.toString(
                                game.releaseDate
                            )
                        )
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                        Text(
                            detail.description
                        )
                        .padding()
                    }
                }
            }
        }
        .onAppear(perform: loadData)
        .toolbar {
            ToolbarItem {
                HStack {
                    Text("") // To remove blue color.
                    FavoriteButton(
                        favorite: FavoriteItem(
                            isFavorite: getIsFavorite(),
                            onFavorite: onFavorite,
                            width: 30,
                            height: 30
                        )
                    )
                }
            }
        }
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailPage(
                game: GameItem(
                    gameId: "3498",
                    name: "Games C Games C Games C Games C",
                    imageLocation: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg",
                    rating: 1,
                    releaseDate: Date()
                )
            )
        }

    }
}
