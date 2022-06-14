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
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.lastVisitDate, order: .reverse)],
        predicate: NSPredicate(format: "isFavorite == YES")
    )
    var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.trackId) { item in
                    let detailsVM = DetailsViewModel(movie: item)
                    NavigationLink(destination: DetailsView(viewModel: detailsVM),
                                   tag: Int(item.trackId),
                                   selection: $selectedTrackId) {
                        MainListItemView(viewModel: MainListItemViewModel(item: item))
                    }
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
