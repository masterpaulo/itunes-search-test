//
//  MainView.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        TabView {
            SearchListView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            FavoritesListView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
