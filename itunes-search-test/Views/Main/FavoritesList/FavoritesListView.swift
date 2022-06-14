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
                        FavoritesListItemView(viewModel: FavoritesListItemViewModel(item: item))
                    }
                    
                }
                .onDelete(perform: removeFavorites)
            }
            .toolbar(content: {
                if !items.isEmpty {
                    EditButton()
                }
            })
            .listStyle(InsetListStyle())
            .overlay(content: {
                if items.isEmpty {
                    noDataFoundView
                }
            })
            .navigationBarTitle("Favorites")
        }
    }
    
    private func removeFavorites(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            viewModel.removeFavorite(item: item)
        }
    }
    
    // MARK: - Accessory Views
    
    @ViewBuilder
    var noDataFoundView: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "questionmark.folder")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.secondary)
            Text("List is Empty")
                .foregroundColor(.secondary)
                .font(.system(size: 24))
                .bold()
            
            Text("You do not have any Favorite Items yet.")
                .foregroundColor(.secondary)
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
    }
}
