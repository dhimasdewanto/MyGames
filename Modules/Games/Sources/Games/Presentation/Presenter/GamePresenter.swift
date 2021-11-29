//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 25/11/21.
//

import Core
import Combine
import Foundation

public class GamePresenter: GetDataPresenter<
    GameDomainRequest,
    [GameDomainModel],
    Interactor<
        GameDomainRequest,
        [GameDomainModel],
        GameRepository<
            GameRemoteSource,
            GameTransformer
        >
    >
> {
    
}
