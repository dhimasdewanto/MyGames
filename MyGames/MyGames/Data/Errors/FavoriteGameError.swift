//
//  FavoriteGameError.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

enum FavoriteGameError: String, Error {
    case failedToGetFavorites = "Error while get list favorites"
    case failedToGetFavorite = "Error while get favorite"
    case coreDataIdIsEmpty = "Core Data ID is empty"
    case entityIsEmpty = "Entity is empty"
}
