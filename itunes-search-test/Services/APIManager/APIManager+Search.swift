//
//  APIManager+Search.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation

extension APIManager {
    /// Fetch list of movie items matching a search keyword.
    ///
    /// - Parameters:
    ///   - term: The URL-encoded text string you want to search for. For example: jack+johnson.
    ///   - countryCode: The two-letter country code for the store you want to search. The search uses the default store front for the specified country. For example: US. Defaults to "AU"
    ///
    func searchMovieItems(term: String, countryCode: String = "AU", completion:@escaping (Result<ItemList, AppError>)->Void) {
        request(route: SearchRoutes.searchItems(term: term, countryCode: countryCode, media: MediaType.movie.rawValue), completion: completion)
    }
    
    /// Fetch list of items matching a search keyword and a provided media type.
    /// NOTE: This is only an example accessibility method. It is currently not used in the App. For reference purposes only.
    ///
    /// - Parameters:
    ///   - term: The URL-encoded text string you want to search for. For example: jack+johnson.
    ///   - countryCode: The two-letter country code for the store you want to search. The search uses the default store front for the specified country. For example: US. Defaults to "AU"
    ///   - media: A `MediaType` value describing the media type you want to search for. For example: `movie`
    ///
    func searchItems(term: String, countryCode: String = "AU", media: MediaType, completion:@escaping (Result<ItemList, AppError>)->Void) {
        request(route: SearchRoutes.searchItems(term: term, countryCode: countryCode, media: media.rawValue), completion: completion)
    }
}
