//
//  DetailsViewModel.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Combine

class DetailsViewModel: ObservableObject {
    
    var movie: Item
    
    @Published var favorite: Bool {
        didSet {
            movie.isFavorite = favorite
            DataManager.shared.save(item: movie)
        }
    }
    
    // MARK: - init
    
    init(movie: Item) {
        self.movie = movie
        self.favorite = movie.isFavorite
    }
    
    // MARK: - Methods
    
    func toggleFavorite() {
        favorite.toggle()
    }
    
    func saveItemToContext() {
        DataManager.shared.save(item: movie)
    }
}

// MARK: - Display Properites

extension DetailsViewModel {
    var title: String { movie.trackName }
    var genre: String { movie.genre }
    var description: String { movie.longDescription ?? "" }
    var imageURL: String { movie.artworkStringUrl }
    
    var lastVisitDateText: String? {
        guard let date = movie.lastVisitDate?.stringFormat("MM/dd/YYYY") else { return nil }
        return "Last visited on: \(date)"
    }
}
