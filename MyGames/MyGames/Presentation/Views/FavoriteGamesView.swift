//
//  FavoriteGamesView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 29/08/21.
//

import SwiftUI

/// View for favorite games.
struct FavoriteGamesView: View {

//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(
//        entity: CoreGame.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(
//                keyPath: \CoreGame.rating,
//                ascending: false
//            )
//        ],
//        predicate: NSPredicate(
//            format: "isFavorite == true"
//        )
//    ) var coreGames: FetchedResults<CoreGame>

    /// Convert [CoreGame] to [GameItem].
//    private func toGameItem(coreGame: CoreGame) -> GameItem {
//        return GameItem(
//            gameId: coreGame.gameId ?? "",
//            name: coreGame.name ?? "",
//            imageLocation: coreGame.imageLocation ?? "",
//            rating: coreGame.rating,
//            releaseDate: coreGame.releaseDate ?? Date()
//        )
//    }

    var body: some View {
        Section {
//            if coreGames.isEmpty {
//                Text("Favorite is Empty")
//            } else {
//                ScrollView {
//                    LazyVStack {
//                        ForEach(coreGames.indices, id: \.self) { index in
//                            let coreGame = coreGames[index]
//                            let game = toGameItem(coreGame: coreGame)
//
//                            NavigationLink(
//                                destination: DetailPage(
//                                    game: game
//                                )
//                            ) {
//                                ListTileComponent(
//                                    game: game,
//                                    ranking: index + 1,
//                                    favorite: FavoriteItem(
//                                        isFavorite: coreGame.isFavorite,
//                                        onFavorite: {
//                                            coreGame.isFavorite = !coreGame.isFavorite
//                                            PersistenceController.shared.save()
//                                        }
//                                    )
//                                )
//                            }
//                        }
//                    }
//                }
//            }
        }
        .navigationTitle("Favorites")
    }
}

struct FavoriteGamesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavoriteGamesView()
        }
    }
}
