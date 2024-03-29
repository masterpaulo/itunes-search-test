//
//  FavoritesListViewModel.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation

import CoreData
import SwiftUI
import Combine

class FavoritesListViewModel: BaseViewModel {
    
    // MARK: - Methods
    
    func removeFavorite(item: Item) {
        item.isFavorite = false
        DataManager.shared.save(item: item)
    }
}
