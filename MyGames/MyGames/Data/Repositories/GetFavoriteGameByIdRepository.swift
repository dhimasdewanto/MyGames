//
//  GetFavoriteGameByIdRepository.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core
import Combine

public class GetFavoriteGameByIdRepository<
    LocSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
LocSource.Response == FavoriteGameEntity,
LocSource.Request == Void,
Transformer.RequestData == String,
Transformer.RequestDomain == String,
Transformer.ResponseData == FavoriteGameEntity,
Transformer.ResponseDomain == FavoriteGameDomainModel {

    public typealias Request = String

    public typealias Response = FavoriteGameDomainModel

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
        guard let coreId = request else {
            return Future<Response, Error> { completion in
                completion(.failure(FavoriteGameError.coreDataIdIsEmpty))
            }.eraseToAnyPublisher()
        }

        return localeSource.get(coreId: coreId).map { response in
            return self.mapper.responseToDomain(response)
        }.eraseToAnyPublisher()
    }

}
