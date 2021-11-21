//
//  Injection.swift
//  MyGames
//
//  Created by TMLI IT Dev on 22/11/21.
//

import Core
import Games
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
}
