//
//  FavoritesListView.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import SwiftUI

struct FavoritesListView: View {
    @Environment(\.managedObjectContext) var context
    
    @StateObject private var viewModel: FavoritesListViewModel = FavoritesListViewModel()
    
    @State private var selectedTrackId: Int?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(1...10, id: \.self) { i in
                    Text("Favorite item \(i)")
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
    }
}
