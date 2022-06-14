//
//  Constants.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation

struct K {
    struct iTunesServer {
        static let baseURL = "https://itunes.apple.com"
    }
    
    struct APIParameterKey {
        static let term = "term"
        static let countryCode = "country"
        static let media = "media"
        static let trackId = "trackId"
        static let trackName = "trackName"
        static let artworkStringUrl = "artworkStringUrl"
        static let currency = "currency"
        static let trackPrice = "trackPrice"
        static let genre = "genre"
        static let longDescription = "longDescription"
        static let isFavorite = "isFavorite"
        static let pageId = "pageId"
        static let viewModel = "viewModel"
    }
    
    struct CoreDataEntity {
        static let item = "Item"
    }
    
    static let appName = "itunes_search_test"
}
