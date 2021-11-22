//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 22/11/21.
//

import Core
import Combine
import Foundation

public class DetailGameRepository<
    DetailGameRemoteSource: RemoteDataSource,
    Transformer: Mapper>: Repository
where
DetailGameRemoteSource.Response == DetailGameResponse,
DetailGameRemoteSource.Request == DetailGameDataRequest,
Transformer.RequestData == DetailGameDataRequest,
Transformer.RequestDomain == DetailGameDomainRequest,
Transformer.ResponseData == DetailGameResponse,
Transformer.ResponseDomain == DetailGameDomainModel
{
    
    public typealias Request = DetailGameDomainRequest
    
    public typealias Response = DetailGameDomainModel
    
    private let remoteSource: DetailGameRemoteSource
    private let mapper: Transformer
    
    public init(
        remoteSource: DetailGameRemoteSource,
        mapper: Transformer
    ) {
        self.remoteSource = remoteSource
        self.mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return remoteSource.execute(
            request: mapper.requestToData(request)
        ).map { game in
            return self.mapper.responseToDomain(game)
        }.eraseToAnyPublisher()
    }
    
}
