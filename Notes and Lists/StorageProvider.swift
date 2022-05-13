//
//  StorageProvider.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/29/22.
//

import Foundation
import CoreData

class StorageProvider: ObservableObject {
    let persistentContainer: NSPersistentCloudKitContainer
    
    init() {
        let id = "group.com.magdiel.Notes-and-Lists"
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: id)!
        let url = container.appendingPathComponent("Model.sqlite")
        persistentContainer = NSPersistentCloudKitContainer(name: "Model")
        persistentContainer.persistentStoreDescriptions.first!.url = url
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider {
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
    }
    func delete(_ object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        save()
    }
}
