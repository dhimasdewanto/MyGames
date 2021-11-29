//
//  SetFavoriteGameTransformer.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core

public struct SetFavoriteGameTransformer: Mapper {

    public typealias RequestData = FavoriteGameEntity

    public typealias RequestDomain = FavoriteGameDomainRequest

    public typealias ResponseData = Void

    public typealias ResponseDomain = Void

    public init () {}

    public func requestToData(_ request: FavoriteGameDomainRequest?) -> FavoriteGameEntity? {
        if let data = request {
            return FavoriteGameEntity(
                gameId: data.gameId,
                name: data.name,
                imageLocation: data.imageLocation,
                rating: data.rating,
                releaseDate: data.releaseDate,
                isFavorite: true
            )
        }
        return nil
    }

    public func requestToDomain(_ request: FavoriteGameEntity?) -> FavoriteGameDomainRequest? {
        if let data = request {
            return FavoriteGameDomainRequest(
                gameId: data.gameId,
                name: data.name,
                imageLocation: data.imageLocation,
                rating: data.rating,
                releaseDate: data.releaseDate
            )
        }
        return nil
    }

    public func responseToData(_ response: Void) {
        return
    }

    public func responseToDomain(_ response: Void) {
        return
    }

}
