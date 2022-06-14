//
//  SearchRoutes.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import Foundation
import Alamofire

enum SearchRoutes: URLRequestConvertible, APIConfigurationProtocol {

    case searchItems(term: String, countryCode: String, media: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .searchItems:
            return .get
        }
    }

    // MARK: - Path
    var path: String {
        switch self {
        case .searchItems:
            return "/search"
        }
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .searchItems(let term, let countryCode, let media):
            
            return [K.APIParameterKey.term: term, K.APIParameterKey.countryCode: countryCode, K.APIParameterKey.media: media]
        }
    }
}
