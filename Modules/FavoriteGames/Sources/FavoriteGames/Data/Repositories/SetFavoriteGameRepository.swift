//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 27/11/21.
//

import Core
import Combine
import Foundation

public class SetFavoriteGameRepository<
    FavoriteGamesLocaleSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
FavoriteGamesLocaleSource.Response == FavoriteGameEntity,
FavoriteGamesLocaleSource.Request == Void,
Transformer.RequestData == FavoriteGameEntity,
Transformer.RequestDomain == FavoriteGameDomainRequest,
Transformer.ResponseData == Void,
Transformer.ResponseDomain == Void
{
    
    public typealias Request = FavoriteGameDomainRequest
    
    public typealias Response = Void
    
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
        guard let data = self.mapper.requestToData(request) else {
            return Future<Response, Error> { completion in
                completion(.failure(FavoriteGameError.entityIsEmpty))
            }.eraseToAnyPublisher()
        }
        
        return localeSource.update(
            id: data.gameId,
            entity: data
        ).eraseToAnyPublisher()
    }
    
}
