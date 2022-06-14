//
//  MainListItemView.swift
//  itunes-search-test
//
//  Created by Master Paulo on 6/14/22.
//

import SwiftUI

struct MainListItemView: View {
    
    @ObservedObject var viewModel: MainListItemViewModel
    
    var body: some View {
        HStack {
            Image("placeholder")
                .resizable()
                .frame(width: 90, height: 90)
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .fontWeight(.medium)
                Text(viewModel.genre)
                    .font(.system(size: 12))
            }
            .padding()
            
            Spacer()
            
            Button {
                viewModel.toggleFavorite()
            } label: {
                Image(systemName: viewModel.favorite ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            .buttonStyle(.borderless)

                
        }
        .frame(height: 90)
    }
}
