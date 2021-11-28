//
//  FavoriteGameLocaleSource.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core
import Combine
import CoreData

public class FavoriteGamesLocaleSource: LocaleDataSource {

    private let managedObjectContext: NSManagedObjectContext

    public init(
        managedObjectContext: NSManagedObjectContext? = nil
    ) {
        if let context = managedObjectContext {
            self.managedObjectContext = context
        } else {
            self.managedObjectContext = PersistenceController.shared.container.viewContext
        }
    }

    public typealias Request = Void

    public typealias Response = FavoriteGameEntity

    public func list(
        request: Void?
    ) -> AnyPublisher<[Response], Error> {
        return Future<[Response], Error> { completion in
            let fetch = NSFetchRequest<FavoriteCore>(
                entityName: CoreDataConfigs.coreDataEntity
            )
            let predicate = NSPredicate(format: "isFavorite == true")
            fetch.predicate = predicate

            do {
                let listCoreData = try self.managedObjectContext.fetch(fetch)
                let listData = CoreFavoriteTransformer().toEntities(
                    coreGames: listCoreData
                )
                completion(.success(listData))
            } catch {
                completion(.failure(FavoriteGameError.failedToGetFavorites))
            }
        }.eraseToAnyPublisher()
    }

    public func add(entities: [Response]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { completion in
            for entity in entities {
                self.createCoreData(entity: entity)
                PersistenceController.shared.save()
            }
            completion(.success(()))
        }.eraseToAnyPublisher()
    }

    public func get(coreId: String) -> AnyPublisher<Response, Error> {
        return Future<FavoriteGameEntity, Error> { completion in
            let listCoreData = PersistenceController.shared.getListData()
            let findedNil = listCoreData.first { coreData in
                return coreData.gameId == coreId && coreData.isFavorite == true
            }
            guard let finded = findedNil else {
                completion(.failure(FavoriteGameError.failedToGetFavorite))
                return
            }
            let entity = CoreFavoriteTransformer().toEntity(coreGame: finded)
            completion(.success(entity))
        }.eraseToAnyPublisher()
    }

    /// Update game data in Core Data.
    ///
    /// If not exist, it will create instead.
    public func update(coreId: String, entity: Response) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { completion in
            let listCoreData = PersistenceController.shared.getListData()
            guard let coreData = (listCoreData.first { coreData in
                return coreData.gameId == coreId
            }) else {
                self.createCoreData(entity: entity)
                PersistenceController.shared.save()
                completion(.success(()))
                return
            }

            coreData.isFavorite = !coreData.isFavorite
            PersistenceController.shared.save()

            completion(.success(()))
        }.eraseToAnyPublisher()
    }

    private func createCoreData(entity: Response) {
        let game = entity
        let coreGame = FavoriteCore(context: managedObjectContext)
        coreGame.gameId = game.gameId
        coreGame.imageLocation = game.imageLocation
        coreGame.name = game.name
        coreGame.rating = game.rating
        coreGame.releaseDate = game.releaseDate
        coreGame.isFavorite = true
    }

}
