//
//  SearchListItemView.swift
//  itunes-search-test
//
//  Created by Master Paulo on 6/14/22.
//

import SwiftUI
import Kingfisher

struct SearchListItemView: View {
    
    @ObservedObject var viewModel: SearchListItemViewModel
    
    var body: some View {
        HStack {
            KFImage.url(URL(string: viewModel.imageURL))
                .placeholder {
                    Image("placeholder")
                        .resizable()
                        .frame(height: 100)
                        .aspectRatio(contentMode: .fit)
                }
                .resizable()
                .frame(height: 100)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                Text(viewModel.genre)
                    .font(.system(size: 12))
                Text(viewModel.price)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            
            Spacer()
            
            Button {
                viewModel.toggleFavorite()
            } label: {
                Image(systemName: viewModel.favorite ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            .buttonStyle(.borderless)

        }
        .padding(.vertical, 2)
    }
}

struct SearchListItemView_Previews: PreviewProvider {
    static let movie = Item(trackId: 12,
                            trackName: "Jumanji",
                            artworkStringUrl: "",
                            genre: "Action",
                            trackPrice: 13.00,
                            currency: "AUD",
                            longDescription: "",
                            isFavorite: true,
                            lastVisitDate: Date())
    static var previews: some View {
        SearchListItemView(viewModel: SearchListItemViewModel(item: movie))
            .previewLayout(PreviewLayout.fixed(width: 300, height: 90))
    }
}
