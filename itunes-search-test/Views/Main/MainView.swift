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
                    
                    NavigationLink(destination: Text(movie.trackName),
                                   tag: Int(movie.trackId),
                                   selection: $selectedTrackId) {
                        MainListItemView(viewModel: MainListItemViewModel(item: movie))
                    }
                }
                
            }
            .searchable(text: $viewModel.searchText)
            .navigationBarTitle("Movies")
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
