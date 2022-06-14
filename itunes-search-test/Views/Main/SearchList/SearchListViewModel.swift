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
    
    @Published var selectedItem: Item?

    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.lastVisitDate, order: .reverse)],
        predicate: NSPredicate(format: "lastVisitDate != nil")
    )
    var vistedItems: FetchedResults<Item>
    
    // MARK: - init
    
    override init() {
        super.init()
        self.bindViewModel()
    }
    
    // MARK: - Methods
    
    func clearRecentVisited(items: [Item]) {
        items.forEach { item in
            item.lastVisitDate = nil
            DataManager.shared.save(item: item)
        }
    }
}

// MARK: - Bindings

extension SearchListViewModel {
    func bindViewModel() {
        bindSearhText()
        bindManagedObjectConttextDidSave()
    }
    
    private func bindSearhText() {
        $searchText
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { [unowned self] text in
                switch text.count {
                case ...0:
                    self.movieList = []
                case 3...:
                    self.fetchItems(search: text)
                default:
                    break
                }
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
    
    var showRecentlyVisited: Bool {
        movieList.isEmpty && loadingState == .idle && searchText.isEmpty
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
