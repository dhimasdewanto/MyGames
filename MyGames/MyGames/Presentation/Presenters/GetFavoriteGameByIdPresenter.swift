//
//  GetFavoriteGameByIdPresenter.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core
import Combine
import Foundation

public class GetFavoriteGameByIdPresenter: GetDataPresenter<
    String,
    FavoriteGameDomainModel,
    Interactor<
        String,
        FavoriteGameDomainModel,
        GetFavoriteGameByIdRepository<
            FavoriteGamesLocaleSource,
            GetFavoriteGameByIdTransformer
        >
    >
> {

}
