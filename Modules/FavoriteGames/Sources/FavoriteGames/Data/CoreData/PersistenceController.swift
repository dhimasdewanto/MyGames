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
        let bundle = Bundle.module
        let modelURL = bundle.url(
            forResource: CoreDataConfigs.coreDataName,
            withExtension: ".momd"
        )!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        
        container = NSPersistentContainer(
            name: CoreDataConfigs.coreDataName,
            managedObjectModel: model
        )
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    /// Get list games from Core Data.
    func getListData() -> [FavoriteCore] {
        let fetch = NSFetchRequest<FavoriteCore>(
            entityName: CoreDataConfigs.coreDataEntity
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
