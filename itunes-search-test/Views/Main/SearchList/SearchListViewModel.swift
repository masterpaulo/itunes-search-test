//
//  SearchListViewModel.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation

import CoreData
import SwiftUI
import Combine

class SearchListViewModel: BaseViewModel {
    
    var context = DataManager.shared.container.viewContext
    
   // MARK: - Published Properites
    
    @Published var showErrorMessage: String?
    
    @Published var searchText: String = ""
    
    @Published var movieList: [Item] = []

    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    // MARK: - init
    
    override init() {
        super.init()
        self.bindViewModel()
    }
    
    // MARK: - Bindings
    
    func bindViewModel() {
        bindSearhText()
        bindManagedObjectConttextDidSave()
    }
    
    private func bindSearhText() {
        $searchText
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { [unowned self] text in
                // Only trigger request if search text has more than 3 characters
                guard text.count > 3 else { return }
                self.fetchItems(search: text)
            }
            .store(in: &subscriptions)
    }
    
    private func bindManagedObjectConttextDidSave() {
        NotificationCenter.default
            .publisher(for: .NSManagedObjectContextDidSave, object: context)
            .sink { _ in
                self.movieList = self.movieList
            }
            .store(in: &subscriptions)
    }

}

// MARK: - Display Properties

extension SearchListViewModel {
    var showNotTableDataView: Bool {
        !searchText.isEmpty && movieList.isEmpty && loadingState == .loaded
    }
    
    var showLoadingIndicator: Bool {
        movieList.isEmpty && loadingState == .loading
    }
}

// MARK: - Network Connections

extension SearchListViewModel {
    func fetchItems(search text: String) {
        let encodedText = text.replacingOccurrences(of: " ", with: "+")
        loadingState = .loading
        requestLoader.searchMovieItems(term: encodedText) { [weak self] result in
            switch result {
            case .success(let list):
                // Map resulting item list to look for existing objects persisted
                self?.movieList = list.items.map { item in
                    DataManager.shared.getItem(with: item.trackId) ?? item
                }
                self?.loadingState = .loaded
            case .failure(let err):
                dump(err)
                self?.loadingState = .error
            }
        }
    }
}
