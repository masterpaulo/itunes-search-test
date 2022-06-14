//
//  Date+StringFormat.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//


import Foundation

extension Date {
    func stringFormat(_ format: String = "MM/dd/YY hh:mm:ss a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
