//
//  Injection.swift
//  MyGames
//
//  Created by Dhimas Dewanto on 22/11/21.
//

import Core
import CoreData
import Games
import DetailGame
import Foundation
import UIKit

/// Injection class.
final class Injection: NSObject {
    /// Singleton of [Injection].
    static let shared = Injection.init()

    func provideGames() -> GamePresenter {
        let remote = GameRemoteSource()
        let mapper = GameTransformer()
        let repository = GameRepository(
            gameRemoteSource: remote,
            mapper: mapper
        )
        let useCase = Interactor(repository: repository)
        return GamePresenter(
            useCase: useCase
        )
    }

    func provideDetailGame() -> DetailGamePresenter {
        let remote = DetailGameRemoteSource()
        let mapper = DetailGameTransformer()
        let repository = DetailGameRepository(
            remote: remote,
            mapper: mapper
        )
        let useCase = Interactor(repository: repository)
        return DetailGamePresenter(
            useCase: useCase
        )
    }

    func provideFavorite() -> GetFavoriteGamesPresenter {
        let localeSource = FavoriteGamesLocaleSource()
        let mapper = GetFavoriteGamesTransfomer()
        let repository = GetFavoriteGamesRepository(
            localeSource: localeSource,
            mapper: mapper
        )
        let useCase = Interactor(repository: repository)
        return GetFavoriteGamesPresenter(
            useCase: useCase
        )
    }

    func provideSetFavorite() -> SetFavoriteGamePresenter {
        let localeSource = FavoriteGamesLocaleSource()
        let mapper = SetFavoriteGameTransformer()
        let repository = SetFavoriteGameRepository(
            localeSource: localeSource,
            mapper: mapper
        )
        let useCase = Interactor(repository: repository)
        return SetFavoriteGamePresenter(
            useCase: useCase
        )
    }

    func provideFavoriteById() -> GetFavoriteGameByIdPresenter {
        let localeSource = FavoriteGamesLocaleSource()
        let mapper = GetFavoriteGameByIdTransformer()
        let repository = GetFavoriteGameByIdRepository(
            localeSource: localeSource,
            mapper: mapper
        )
        let useCase = Interactor(repository: repository)
        return GetFavoriteGameByIdPresenter(
            useCase: useCase
        )
    }
}
