//
//  GetFavoriteGameByIdTransformer.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core

public struct GetFavoriteGameByIdTransformer: Mapper {

    public typealias RequestData = String

    public typealias RequestDomain = String

    public typealias ResponseData = FavoriteGameEntity

    public typealias ResponseDomain = FavoriteGameDomainModel

    public init() {}

    public func requestToData(_ request: String?) -> String? {
        return request
    }

    public func requestToDomain(_ request: String?) -> String? {
        return request
    }

    public func responseToData(_ response: FavoriteGameDomainModel) -> FavoriteGameEntity {
        return FavoriteGameEntity(
            gameId: response.gameId,
            name: response.name,
            imageLocation: response.imageLocation,
            rating: response.rating,
            releaseDate: response.releaseDate,
            isFavorite: response.isFavorite
        )
    }

    public func responseToDomain(_ response: FavoriteGameEntity) -> FavoriteGameDomainModel {
        return FavoriteGameDomainModel(
            gameId: response.gameId,
            name: response.name,
            imageLocation: response.imageLocation,
            rating: response.rating,
            releaseDate: response.releaseDate,
            isFavorite: response.isFavorite
        )
    }

}
