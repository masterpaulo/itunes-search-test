//
//  DataManager+Item.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation
import CoreData

extension DataManager {
    /// Save item to persistence container. If exists, update instead.
    ///
    /// - Parameters:
    ///   - item: The item to persist
    @discardableResult
    func save(item: Item) -> Result<Item, AppError> {
        let context = self.container.viewContext
        let fetchRequest = NSFetchRequest<Item>(entityName: K.CoreDataEntity.item)

        fetchRequest.predicate = NSPredicate(format: "\(K.APIParameterKey.trackId) = %@", argumentArray: [item.trackId])

        do {
            let results = try context.fetch(fetchRequest)
            if let existingItem = results.first {
                existingItem.setValue(item.isFavorite, forKey: K.APIParameterKey.isFavorite)
            } else {
                context.insert(item)
            }
            
            try context.save()
            return .success(item)
        } catch {
            print("Fetch Failed: \(error)")
            return .failure(AppError.failed(error))
        }
    }
    
    /// Save item to persistence container. If exists, update instead.
    ///
    /// - Parameters:
    ///   - item: The item to persist
    @discardableResult
    func getItem(with trackId: Int64) -> Item? {
        let context = self.container.viewContext
        let fetchRequest = NSFetchRequest<Item>(entityName: K.CoreDataEntity.item)

        fetchRequest.predicate = NSPredicate(format: "\(K.APIParameterKey.trackId) = %@", argumentArray: [trackId])

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            return nil
        }
    }
}
