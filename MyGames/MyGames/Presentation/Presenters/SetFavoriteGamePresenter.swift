//
//  SetFavoriteGamePresenter.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core
import Combine
import Foundation

public class SetFavoriteGamePresenter: GetDataPresenter<
    FavoriteGameDomainRequest,
    Void,
    Interactor<
        FavoriteGameDomainRequest,
        Void,
        SetFavoriteGameRepository<
            FavoriteGamesLocaleSource,
            SetFavoriteGameTransformer
        >
    >
> {

}
