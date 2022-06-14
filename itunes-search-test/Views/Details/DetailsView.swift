//
//  DetailsView.swift
//  itunes-search-test
//
//  Created by John Paulo on 6/14/22.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    @StateObject var viewModel: DetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    KFImage.url(URL(string: viewModel.movie.artworkStringUrl))
                        .placeholder {
                            Image("placeholder")
                                .resizable()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.movie.trackName)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(viewModel.movie.genre)
                            .font(.system(size: 12))
                            .fontWeight(.thin)
                    }
                    .padding()
                    
                }
                .padding()

                
                Text(viewModel.description)
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                
                if let lastVisitText = viewModel.lastVisitDateText {
                    Text(lastVisitText)
                        .foregroundColor(.purple)
                        .font(.system(size: 10))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 30)
                }
            }
            
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.toggleFavorite()
                } label: {
                    Image(systemName: viewModel.favorite ? "star.fill" : "star")
                }
            }
        }
        .onAppear {
            viewModel.saveItemToContext()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static let movie = Item(trackId: 12,
                            trackName: "Jumanji",
                            artworkStringUrl: "",
                            genre: "Action",
                            trackPrice: 13.00,
                            currency: "AUD",
                            longDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                            isFavorite: true,
                            lastVisitDate: Date())
    static var previews: some View {
        NavigationView {
            DetailsView(viewModel: DetailsViewModel(movie: movie))
        }
    }
}
