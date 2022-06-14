//
//  MainViewModel.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation

import CoreData
import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    
   // MARK: - Published Properites
    
    @Published var showErrorMessage: String?
    
    @Published var searchText: String = ""
    
    @Published var movieList: [Item] = []

    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    // MARK: - init
    
    init() {
        
        self.bindViewModel()
    }
    
    // MARK: - Bindings
    
    func bindViewModel() {
        bindSearhText()
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

}

// MARK: - Network Connections

extension MainViewModel {
    func fetchItems(search text: String) {
        // Implement fetch items here
    }
}

