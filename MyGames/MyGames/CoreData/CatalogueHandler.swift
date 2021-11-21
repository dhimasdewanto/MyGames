//
//  CatalogueController.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 29/08/21.
//

import SwiftUI
import CoreData

/// Handler for Catalogue Core Data.
class CatalogueHandler {
    /// Get is favorite from comparison of coreGames and game.
    func getIsFavorite(
        coreGames: FetchedResults<CoreGame>,
        game: GameItem
    ) -> Bool {
        return coreGames.contains { coreGame in
            return coreGame.gameId == game.gameId && coreGame.isFavorite == true
        }
    }

    /// Set is favorite from [GameItem].
    func setIsFavorite(
        context: NSManagedObjectContext,
        coreGames: FetchedResults<CoreGame>,
        game: GameItem
    ) {
        guard let coreGame = (coreGames.first { coreGame in
            return coreGame.gameId == game.gameId
        }) else {
            createNewGame(
                context: context,
                game: game
            )
            return
        }

        coreGame.isFavorite = !coreGame.isFavorite
        PersistenceController.shared.save()
    }

    /// Insert new game to Core Data.
    func createNewGame(
        context: NSManagedObjectContext,
        game: GameItem
    ) {
        let coreGame = CoreGame(context: context)
        coreGame.gameId = game.gameId
        coreGame.imageLocation = game.imageLocation
        coreGame.name = game.name
        coreGame.rating = game.rating
        coreGame.releaseDate = game.releaseDate
        coreGame.isFavorite = true
        PersistenceController.shared.save()
    }
}
