//
//  SearchListItemViewModel.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Combine

class SearchListItemViewModel: ObservableObject {
    
    let item: Item
    
    @Published var favorite: Bool {
        didSet {
            item.isFavorite = favorite
            DataManager.shared.save(item: item)
        }
    }
    
    // MARK: - init

    init(item: Item) {
        self.item = item
        self.favorite = item.isFavorite
    }
    
    // MARK: - Methods
    
    func toggleFavorite() {
        favorite.toggle()
    }
}

// MARK: - Display Properites

extension SearchListItemViewModel {
    var title: String { item.trackName }
    var genre: String { item.genre }
    var price: String { "\(item.trackPrice) \(item.currency)" }
    var imageURL: String { item.artworkStringUrl }
}
