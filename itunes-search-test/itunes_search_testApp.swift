//
//  itunes_search_testApp.swift
//  itunes-search-test
//
//  Created by Master Paulo on 6/14/22.
//

import SwiftUI

@main
struct itunes_search_testApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
