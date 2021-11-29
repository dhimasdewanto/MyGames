//
//  GetFavoriteGamesPresenter.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core
import Combine
import Foundation

public class GetFavoriteGamesPresenter: GetDataPresenter<
    Void,
    [FavoriteGameDomainModel],
    Interactor<
        Void,
        [FavoriteGameDomainModel],
        GetFavoriteGamesRepository<
            FavoriteGamesLocaleSource,
            GetFavoriteGamesTransfomer
        >
    >
> {

}
