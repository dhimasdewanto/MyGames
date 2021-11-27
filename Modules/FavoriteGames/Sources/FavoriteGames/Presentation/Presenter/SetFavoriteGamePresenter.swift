//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 27/11/21.
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
