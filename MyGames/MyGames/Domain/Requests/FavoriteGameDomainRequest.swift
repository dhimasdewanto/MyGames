//
//  FavoriteGameDomainRequest.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Foundation

public struct FavoriteGameDomainRequest {
    public let gameId: String
    public let name: String
    public let imageLocation: String
    public let rating: Double
    public let releaseDate: Date

    public init(
        gameId: String,
        name: String,
        imageLocation: String,
        rating: Double,
        releaseDate: Date
    ) {
        self.gameId = gameId
        self.name = name
        self.imageLocation = imageLocation
        self.rating = rating
        self.releaseDate = releaseDate
    }
}
