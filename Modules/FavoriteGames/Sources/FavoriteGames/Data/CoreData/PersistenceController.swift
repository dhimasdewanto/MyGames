//
//  PersistenceController.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 29/11/21.
//

import CoreData

/// Controller for Core Data.
public struct PersistenceController {
    /// Singleton of [PersistenceController].
    public static let shared = PersistenceController()

    public let container: NSPersistentContainer

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
    
    /// Get list games from Core Data.
    func getListData() -> [CoreGame] {
        let fetch = NSFetchRequest<CoreGame>(
            entityName: CoreDataConfigs.coreDataName
        )
        let context = container.viewContext
        do {
            let coreData = try context.fetch(fetch)
            return coreData
        } catch {
            print("Error while getListData")
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
