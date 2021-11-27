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
import FavoriteGames
import UIKit

/// Injection class.
final class Injection: NSObject {
    /// Singleton of [Injection].
    static let shared = Injection.init()

    private func managedObjectContext() -> NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }

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
        let mapper = FavoriteGameTransformer()
        let repository = GetFavoriteGameRepository(
            localeSource: localeSource,
            mapper: mapper
        )
        let useCase = Interactor(repository: repository)
        return GetFavoriteGamesPresenter(
            useCase: useCase
        )
    }

    func provideSetFavorite() -> SetFavoriteGamePresenter {
        let localeSource = FavoriteGamesLocaleSource(
            managedObjectContext: self.managedObjectContext()
        )
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
}
