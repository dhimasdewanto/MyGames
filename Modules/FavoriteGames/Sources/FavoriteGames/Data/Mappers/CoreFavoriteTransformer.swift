//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 25/11/21.
//

import Core
import Foundation
import CoreData

class CoreFavoriteTransformer {
    func toEntity(coreGame: CoreGame) -> FavoriteGameEntity {
        let data = coreGame
        return FavoriteGameEntity(
            gameId: data.gameId ?? "",
            name: data.name ?? "",
            imageLocation: data.imageLocation ?? "",
            rating: data.rating,
            releaseDate: data.releaseDate ?? Date(),
            isFavorite: data.isFavorite
        )
    }
    
    func toEntities(coreGames: [CoreGame]) -> [FavoriteGameEntity] {
        return coreGames.map { data in
            return FavoriteGameEntity(
                gameId: data.gameId ?? "",
                name: data.name ?? "",
                imageLocation: data.imageLocation ?? "",
                rating: data.rating,
                releaseDate: data.releaseDate ?? Date(),
                isFavorite: data.isFavorite
            )
        }
    }
}
