//
//  FavoriteGameEntity.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Foundation

public struct FavoriteGameEntity {
    public let gameId: String
    public let name: String
    public let imageLocation: String
    public let rating: Double
    public let releaseDate: Date
    public let isFavorite: Bool
}
