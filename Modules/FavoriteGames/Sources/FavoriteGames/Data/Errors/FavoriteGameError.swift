//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 25/11/21.
//

enum FavoriteGameError: String, Error {
    case failedToGetFavorites = "Error while get list favorites"
    case failedToGetFavorite = "Error while get favorite"
    case entityIsEmpty = "Entity is empty"
}
