//
//  ITunesSearchApp.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import SwiftUI

@main
struct ITunesSearchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
