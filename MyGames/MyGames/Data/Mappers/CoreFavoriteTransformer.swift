//
//  CoreFavoriteTransformer.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Foundation

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
