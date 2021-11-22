//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 23/11/21.
//

import Core
import Combine
import Foundation

public class DetailGamePresenter: GetDataPresenter<
    DetailGameDomainRequest,
    DetailGameDomainModel,
    Interactor<
        DetailGameDomainRequest,
        DetailGameDomainModel,
        DetailGameRepository<
            DetailGameRemoteSource,
            DetailGameTransformer
        >
    >
> {
    
}
