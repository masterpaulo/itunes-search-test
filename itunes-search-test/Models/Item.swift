//
//  Item.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    @NSManaged var trackId: Int64
    @NSManaged var trackName: String
    @NSManaged var artworkStringUrl: String
    @NSManaged var genre: String
    @NSManaged var trackPrice: Float
    @NSManaged var currency: String
    @NSManaged var longDescription: String
    
    @NSManaged var lastVisitDate: Date?
    @NSManaged var isFavorite: Bool
    
}
