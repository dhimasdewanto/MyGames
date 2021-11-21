//
//  ListComponent.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/08/21.
//

import SwiftUI

/// Component for list view of [GameItem].
struct ListViewComponent: View {
    let listGames: [GameItem]
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

    private func onFavorite(game: GameItem) {
        handler.setIsFavorite(
            context: managedObjectContext,
            coreGames: coreGames,
            game: game
        )
    }

    private func getIsFavorite(game: GameItem) -> Bool {
        return handler.getIsFavorite(
            coreGames: coreGames,
            game: game
        )
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<listGames.count) { index in
                    let game = listGames[index]
                    NavigationLink(
                        destination: DetailPage(
                            game: game
                        )
                    ) {
                        ListTileComponent(
                            game: game,
                            ranking: index + 1,
                            favorite: FavoriteItem(
                                isFavorite: getIsFavorite(game: game),
                                onFavorite: {
                                    onFavorite(game: game)
                                }
                            )
                        )
                    }
                }
            }
        }
    }
}

struct ListComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListViewComponent(
                listGames: [
                    GameItem(
                        gameId: "3",
                        name: "Games C Games C Games C Games C",
                        imageLocation: "gtav",
                        rating: 1,
                        releaseDate: Date()
                    )
                ]
            )
        }
    }
}
