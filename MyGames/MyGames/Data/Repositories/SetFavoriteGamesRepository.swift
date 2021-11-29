//
//  SetFavoriteGamesRepository.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core
import Combine
import Foundation

public class SetFavoriteGameRepository<
    LocSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
LocSource.Response == FavoriteGameEntity,
LocSource.Request == Void,
Transformer.RequestData == FavoriteGameEntity,
Transformer.RequestDomain == FavoriteGameDomainRequest,
Transformer.ResponseData == Void,
Transformer.ResponseDomain == Void {

    public typealias Request = FavoriteGameDomainRequest

    public typealias Response = Void

    private let localeSource: LocSource
    private let mapper: Transformer

    public init(
        localeSource: LocSource,
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
            coreId: data.gameId,
            entity: data
        ).eraseToAnyPublisher()
    }

}
