//
//  GetFavoriteGamesRepository.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core
import Combine

public class GetFavoriteGamesRepository<
    LocSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
LocSource.Response == FavoriteGameEntity,
LocSource.Request == Void,
Transformer.RequestData == Void,
Transformer.RequestDomain == Void,
Transformer.ResponseData == [FavoriteGameEntity],
Transformer.ResponseDomain == [FavoriteGameDomainModel] {

    public typealias Request = Void

    public typealias Response = [FavoriteGameDomainModel]

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
        return localeSource.list(request: nil).map { response in
            return self.mapper.responseToDomain(response)
        }.eraseToAnyPublisher()
    }

}
