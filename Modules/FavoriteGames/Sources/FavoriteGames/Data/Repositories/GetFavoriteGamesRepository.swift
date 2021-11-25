//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 25/11/21.
//

import Core
import Combine
import Foundation

public class GetFavoriteGameRepository<
    FavoriteGamesLocaleSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
FavoriteGamesLocaleSource.Response == FavoriteGameEntity,
FavoriteGamesLocaleSource.Request == Void,
Transformer.RequestData == Void,
Transformer.RequestDomain == Void,
Transformer.ResponseData == [FavoriteGameEntity],
Transformer.ResponseDomain == [FavoriteGameDomainModel]
{
    
    public typealias Request = Void
    
    public typealias Response = [FavoriteGameDomainModel]
    
    private let localeSource: FavoriteGamesLocaleSource
    private let mapper: Transformer
    
    public init(
        localeSource: FavoriteGamesLocaleSource,
        mapper: Transformer
    ) {
        self.localeSource = localeSource
        self.mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return localeSource.list(request: nil).map { response in
            return self.mapper.responseToDomain(response)
        }.eraseToAnyPublisher()
    }
    
}
