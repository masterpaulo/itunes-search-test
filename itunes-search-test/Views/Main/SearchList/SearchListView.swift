//
//  SearchListView.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import SwiftUI

struct SearchListView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @StateObject private var viewModel: SearchListViewModel = SearchListViewModel()

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.lastVisitDate, order: .reverse)],
        predicate: NSPredicate(format: "lastVisitDate != nil")
    )
    var visitedItems: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                
                // Search Results
                ForEach(viewModel.movieList, id: \.trackId) { movie in
                    let detailsVM = DetailsViewModel(movie: movie)
                    NavigationLink(destination: DetailsView(viewModel: detailsVM),
                                   tag: movie,
                                   selection: $viewModel.selectedItem) {
                        SearchListItemView(viewModel: SearchListItemViewModel(item: movie))
                            
                    }
                }
                
                // Recently Visited Items
                if viewModel.showRecentlyVisited && !visitedItems.isEmpty {
                    Section(header: recentVisitsSectionHeaderView) {
                        ForEach(visitedItems, id: \.trackId) { movie in
                            let detailsVM = DetailsViewModel(movie: movie)
                            NavigationLink(destination: DetailsView(viewModel: detailsVM),
                                           tag: movie,
                                           selection: $viewModel.selectedItem) {
                                SearchListItemView(viewModel: SearchListItemViewModel(item: movie))
                                    
                            }
                        }
                    }
                }
                
            }
            .listStyle(InsetListStyle())
            .overlay(content: {
                if viewModel.showNotTableDataView {
                    noDataFoundView
                }
                if viewModel.showLoadingIndicator {
                    loadingIndicator
                }
                if viewModel.showRecentlyVisited && visitedItems.isEmpty {
                    noRecentVisitsdView
                }
            })
            .searchable(text: $viewModel.searchText)
            .onReceive(viewModel.$searchText) { _ in
                viewModel.loadingState = .idle
            }
            .navigationBarTitle("Movies")
        }
    }
    
    @ViewBuilder
    var recentVisitsSectionHeaderView: some View {
        HStack {
            Text("Recently Visited")
            Spacer()
            Button {
                viewModel.clearRecentVisited(items: Array(visitedItems))
            } label: {
                Text("Clear")
            }
        }
    }
    
    // MARK: - Accessory Views
    
    @ViewBuilder
    var noDataFoundView: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "eyeglasses")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, height: 100)
                .foregroundColor(.secondary)
            Text("No Data Found")
                .foregroundColor(.secondary)
                .font(.system(size: 24))
                .bold()
            
            Text("Try using a different search term")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    var noRecentVisitsdView: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .foregroundColor(.secondary)
            Text("Looking for Movies?")
                .foregroundColor(.secondary)
                .font(.system(size: 24))
                .bold()
            
            Text("Type in the search bar to find results")
                .frame(width: 300)
                .multilineTextAlignment(.center)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    var loadingIndicator: some View {
        ProgressView("Loading…")
            .scaleEffect(2)
            .font(.system(size:8))
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
