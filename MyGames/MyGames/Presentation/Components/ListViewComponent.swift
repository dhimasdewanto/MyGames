//
//  ListComponent.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/11/21.
//

import SwiftUI

/// Component for list view of [GameItem].
struct ListViewComponent: View {
    let listGames: [GamePresentationModel]
//    private let handler = CatalogueHandler()
//
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(
//        entity: CoreGame.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(
//                keyPath: \CoreGame.gameId,
//                ascending: true
//            )
//        ]
//    ) var coreGames: FetchedResults<CoreGame>

    private func onFavorite(game: GamePresentationModel) {
//        handler.setIsFavorite(
//            context: managedObjectContext,
//            coreGames: coreGames,
//            game: game
//        )
    }

    private func getIsFavorite(game: GamePresentationModel) -> Bool {
        return false
//        return handler.getIsFavorite(
//            coreGames: coreGames,
//            game: game
//        )
    }

    private func toDetailNavigation<Content: View>(
        game: GamePresentationModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        let router = ListGamesRouter()
        return NavigationLink(
            destination: router.toDetail(for: game)
        ) { content() }
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<listGames.count) { index in
                    let game = listGames[index]
                    toDetailNavigation(game: game) {
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
                    GamePresentationModel(
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
