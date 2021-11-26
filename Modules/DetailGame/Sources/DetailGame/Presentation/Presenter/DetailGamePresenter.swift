//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 23/11/21.
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
