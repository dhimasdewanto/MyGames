//
//  FavoriteGamesView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 29/11/21.
//

import SwiftUI
import FavoriteGames

/// View for favorite games.
struct FavoriteGamesView: View {
    @EnvironmentObject var favoritePresenter: GetFavoriteGamesPresenter

    private func convertGameItems(_ listData: [FavoriteGameDomainModel]) -> [GamePresentationModel] {
        return listData.map { data in
            GamePresentationModel(
                gameId: data.gameId,
                name: data.name,
                imageLocation: data.imageLocation,
                rating: data.rating,
                releaseDate: data.releaseDate
            )
        }
    }

    /// Load data from Core Data.
    private func loadData() {
        favoritePresenter.execute(
            request: nil
        )
    }

    var body: some View {
        StateHandler<[FavoriteGameDomainModel]>(
            state: favoritePresenter.state,
            onLoad: loadData,
            loadingView: AnyView(ProgressView()),
            successView: { state in
                if state.isEmpty {
                    return AnyView(
                        Text("Favorite is Empty")
                    )
                }

                return AnyView(
                    ListViewComponent(
                        listGames: convertGameItems(state)
                    )
                )
            }
        ).navigationTitle("Favorites")
    }
}

struct FavoriteGamesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavoriteGamesView()
        }
    }
}
