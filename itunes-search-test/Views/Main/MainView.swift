//
//  MainView.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject private var viewModel: MainViewModel = MainViewModel()
    
    @State private var selectedTrackId: Int?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movieList, id: \.trackId) { movie in
                    let detailsVM = DetailsViewModel(movie: movie)
                    NavigationLink(destination: DetailsView(viewModel: detailsVM),
                                   tag: Int(movie.trackId),
                                   selection: $selectedTrackId) {
                        MainListItemView(viewModel: MainListItemViewModel(item: movie))
                            
                    }
                }
            }
            .overlay(content: {
                if viewModel.showNotTableDataView {
                    noDataFoundView
                }
                if viewModel.showLoadingIndicator {
                    loadingIndicator
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
    var noDataFoundView: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamation")
            Text("No Data Found")
                .font(.system(size: 24))
                .bold()
            
            Text("Try using a different search term")
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
