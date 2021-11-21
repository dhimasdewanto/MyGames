//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 21/11/21.
//

import Core
import Combine
import Foundation

public class GameRepository<
    GameRemoteSource: RemoteDataSource,
    Transformer: Mapper>: Repository
where
GameRemoteSource.Response == GameItemResponse,
GameRemoteSource.Request == GameDataRequest,
Transformer.RequestData == GameDataRequest,
Transformer.RequestDomain == GameDomainRequest,
Transformer.ResponseData == GameItemResponse,
Transformer.ResponseDomain == [GameDomainModel]
{
    
    public typealias Request = GameDomainRequest
    
    public typealias Response = [GameDomainModel]
    
    private let gameRemoteSource: GameRemoteSource
    private let mapper: Transformer
    
    public init(
        gameRemoteSource: GameRemoteSource,
        mapper: Transformer
    ) {
        self.gameRemoteSource = gameRemoteSource
        self.mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return gameRemoteSource.execute(
            request: mapper.requestToData(request)
        ).map { game in
            return self.mapper.responseToDomain(game)
        }.eraseToAnyPublisher()
    }
    
}
