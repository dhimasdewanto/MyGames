//
//  FavoriteButton.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 29/11/21.
//

import SwiftUI

struct FavoriteButton: View {
    var favorite: FavoriteItem

    var body: some View {
        let width = favorite.width ?? 20
        let height = favorite.height ?? 20

        Button(action: favorite.onFavorite) {
            if favorite.isFavorite {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(
                        width: width,
                        height: height
                    )
                    .foregroundColor(Color(.systemOrange))
            } else {
                Image(systemName: "star")
                    .resizable()
                    .frame(
                        width: width,
                        height: height
                    )
                    .foregroundColor(Color(.systemOrange))
            }
        }
        .padding(.all, 5)
    }
}

struct FavoriteItem {
    var isFavorite: Bool
    var onFavorite: () -> Void
    var width: CGFloat?
    var height: CGFloat?
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(
            favorite: FavoriteItem(
                isFavorite: true,
                onFavorite: {}
            )
        )
    }
}
