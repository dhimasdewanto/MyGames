//
//  GetFavoriteGamesTransformer.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core

public struct GetFavoriteGamesTransfomer: Mapper {

    public typealias RequestData = Void

    public typealias RequestDomain = Void

    public typealias ResponseData = [FavoriteGameEntity]

    public typealias ResponseDomain = [FavoriteGameDomainModel]

    public init() {}

    public func requestToData(_ request: Void?) -> Void? {
        return nil
    }

    public func requestToDomain(_ request: Void?) -> Void? {
        return nil
    }

    public func responseToData(_ response: [FavoriteGameDomainModel]) -> [FavoriteGameEntity] {
        return response.map { res in
            return FavoriteGameEntity(
                gameId: res.gameId,
                name: res.name,
                imageLocation: res.imageLocation,
                rating: res.rating,
                releaseDate: res.releaseDate,
                isFavorite: res.isFavorite
            )
        }
    }

    public func responseToDomain(_ response: [FavoriteGameEntity]) -> [FavoriteGameDomainModel] {
        return response.map { res in
            return FavoriteGameDomainModel(
                gameId: res.gameId,
                name: res.name,
                imageLocation: res.imageLocation,
                rating: res.rating,
                releaseDate: res.releaseDate,
                isFavorite: res.isFavorite
            )
        }
    }

}
