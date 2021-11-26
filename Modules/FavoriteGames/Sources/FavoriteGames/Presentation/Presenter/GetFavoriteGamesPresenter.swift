//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 27/11/21.
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
        GetFavoriteGameRepository<
            FavoriteGamesLocaleSource,
            FavoriteGameTransformer
        >
    >
> {
    
}
