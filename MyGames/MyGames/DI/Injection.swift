//
//  Injection.swift
//  MyGames
//
//  Created by TMLI IT Dev on 22/11/21.
//

import Core
import Games
import DetailGame
import Foundation
import UIKit

/// Injection class.
final class Injection: NSObject {
    /// Singleton of [Injection].
    static let shared = Injection.init()

    func provideGames() -> Interactor<
        GameDomainRequest,
        [GameDomainModel],
        GameRepository<
            GameRemoteSource,
            GameTransformer
        >
    > {
        let remote = GameRemoteSource()
        let mapper = GameTransformer()
        let repository = GameRepository(
            gameRemoteSource: remote,
            mapper: mapper
        )
        return Interactor(repository: repository)
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
}
