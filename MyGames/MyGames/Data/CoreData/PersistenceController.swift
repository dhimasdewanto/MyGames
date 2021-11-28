//
//  PersistenceController.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import CoreData

/// Controller for Core Data.
struct PersistenceController {
    /// Singleton of [PersistenceController].
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(
            name: CoreDataConfigs.coreDataName
        )
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    /// Get list data from Core Data.
    func getListData() -> [FavoriteCore] {
        let fetch = NSFetchRequest<FavoriteCore>(
            entityName: CoreDataConfigs.coreDataEntity
        )
        let context = container.viewContext
        do {
            let coreMeals = try context.fetch(fetch)
            return coreMeals
        } catch {
            print("Error while getListMeals")
            return []
        }
    }

    /// Save Core Data.
    func save(
        completion: @escaping (Error?) -> Void = {_ in}
    ) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    /// Delete Core Data item.
    func delete(
        _ object: NSManagedObject,
        completion: @escaping (Error?) -> Void = {_ in}
    ) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
}
