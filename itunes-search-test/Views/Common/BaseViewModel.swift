//
//  BaseViewModel.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation
import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    
    enum LoadingState {
        case idle
        case loading
        case loaded
        case error
    }
 
    @Published var loadingState: LoadingState = .idle
    
    lazy var requestLoader: APIManager = APIManager.shared
}
