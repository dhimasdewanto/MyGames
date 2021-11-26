//
//  SwiftUIView.swift
//  
//
//  Created by Dhimas Dewanto on 25/11/21.
//

import Core
import Combine
import CoreData

class FavoriteGamesLocaleSource : LocaleDataSource {
    
    private let managedObjectContext: NSManagedObjectContext

    init(
        managedObjectContext: NSManagedObjectContext
    ) {
        self.managedObjectContext = managedObjectContext
    }
    
    typealias Request = Void
    
    typealias Response = FavoriteGameEntity
    
    func list(
        request: Void?
    ) -> AnyPublisher<[FavoriteGameEntity], Error> {
        return Future<[FavoriteGameEntity], Error> { completion in
            let fetch = NSFetchRequest<CoreGame>(
                entityName: CoreDataConfigs.coreDataName
            )
            let predicate = NSPredicate(format: "isFavorite == true")
            fetch.predicate = predicate

            do {
                let coreGames = try self.managedObjectContext.fetch(fetch)
                let data = CoreFavoriteTransformer().toEntities(
                    coreGames: coreGames
                )
                completion(.success(data))
            } catch {
                completion(.failure(FavoriteGameError.failedToGetFavorites))
            }
        }.eraseToAnyPublisher()
    }
    
    func add(entities: [FavoriteGameEntity]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { completion in
            for entity in entities {
                self.createCoreData(entity: entity)
                PersistenceController.shared.save()
            }
            completion(.success(()))
        }.eraseToAnyPublisher()
    }
    
    func get(id: String) -> AnyPublisher<FavoriteGameEntity, Error> {
        return Future<FavoriteGameEntity, Error> { completion in
            let listCoreData = PersistenceController.shared.getListData()
            let findedNil = listCoreData.first { coreData in
                return coreData.gameId == id && coreData.isFavorite == true
            }
            guard let finded = findedNil else {
                completion(.failure(FavoriteGameError.failedToGetFavorite))
                return
            }
            let entity = CoreFavoriteTransformer().toEntity(coreGame: finded)
            completion(.success(entity))
        }.eraseToAnyPublisher()
    }
    
    func update(id: String, entity: FavoriteGameEntity) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { completion in
            let listCoreData = PersistenceController.shared.getListData()
            guard let coreData = (listCoreData.first { coreData in
                return coreData.gameId == id
            }) else {
                self.createCoreData(entity: entity)
                PersistenceController.shared.save()
                completion(.success(()))
                return
            }

            coreData.isFavorite = entity.isFavorite
            PersistenceController.shared.save()

            completion(.success(()))
        }.eraseToAnyPublisher()
    }
    
    private func createCoreData(entity: FavoriteGameEntity) -> Void {
        let game = entity
        let coreGame = CoreGame(context: managedObjectContext)
        coreGame.gameId = game.gameId
        coreGame.imageLocation = game.imageLocation
        coreGame.name = game.name
        coreGame.rating = game.rating
        coreGame.releaseDate = game.releaseDate
        coreGame.isFavorite = true
    }
    
}
