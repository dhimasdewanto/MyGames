//
//  SwiftUIView.swift
//  
//
//  Created by Dhimas Dewanto on 25/11/21.
//

import Core
import Combine
import CoreData

public class FavoriteGamesLocaleSource : LocaleDataSource {
    
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
            let fetch = NSFetchRequest<CoreGame>(
                entityName: CoreDataConfigs.coreDataName
            )
            let predicate = NSPredicate(format: "isFavorite == true")
            fetch.predicate = predicate
            
            let listCoreData = PersistenceController.shared.getListData()
            let listData = CoreFavoriteTransformer().toEntities(
                coreGames: listCoreData
            )
            completion(.success(listData))
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
    
    public func get(id: String) -> AnyPublisher<Response, Error> {
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
    
    /// Update game data in Core Data.
    ///
    /// If not exist, it will create instead.
    public func update(id: String, entity: Response) -> AnyPublisher<Void, Error> {
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
    
    private func createCoreData(entity: Response) -> Void {
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
