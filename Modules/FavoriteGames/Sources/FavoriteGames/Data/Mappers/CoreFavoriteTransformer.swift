//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 25/11/21.
//

import Core
import Foundation
import CoreData

class CoreFavoriteTransformer {
    func toEntity(coreGame: FavoriteCore) -> FavoriteGameEntity {
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
    
    func toEntities(coreGames: [FavoriteCore]) -> [FavoriteGameEntity] {
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
