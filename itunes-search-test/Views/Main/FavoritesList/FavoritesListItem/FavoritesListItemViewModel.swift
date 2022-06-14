//
//  FavoritesListItemViewModel.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Combine

class FavoritesListItemViewModel: ObservableObject {
    
    let item: Item
    
    // MARK: - init

    init(item: Item) {
        self.item = item
    }
    
    // MARK: - Methods
    
    func removeFavorite() {
        item.isFavorite = false
        DataManager.shared.save(item: item)
    }
}

// MARK: - Display Properites

extension FavoritesListItemViewModel {
    var title: String { item.trackName }
    var genre: String { item.genre }
    var price: String { "\(item.trackPrice) \(item.currency)" }
    var imageURL: String { item.artworkStringUrl }
}
