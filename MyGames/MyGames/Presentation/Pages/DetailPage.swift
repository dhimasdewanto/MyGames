//
//  DetailPage.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 12/11/21.
//

import DetailGame
import FavoriteGames
import SwiftUI
import SDWebImageSwiftUI

/// Page to show detail game.
struct DetailPage: View {
    let game: GamePresentationModel

    @EnvironmentObject var detailPresenter: DetailGamePresenter
    @EnvironmentObject var setFavoritePresenter: SetFavoriteGamePresenter
    @EnvironmentObject var getFavoriteByIdPresenter: GetFavoriteGameByIdPresenter

    /// Load detail data from API.
    private func loadData() {
        detailPresenter.execute(
            request: DetailGameDomainRequest(
                gameId: game.gameId
            )
        )
    }

    /// Get is favorite from core data.
//    private func getIsFavorite() -> Bool {
//        return handler.getIsFavorite(
//            coreGames: coreGames,
//            game: game
//        )
//    }

    /// On click favorite button.
    private func onFavorite() {
        setFavoritePresenter.execute(
            request: FavoriteGameDomainRequest(
                gameId: game.gameId,
                name: game.name,
                imageLocation: game.imageLocation,
                rating: game.rating,
                releaseDate: game.releaseDate,
                isFavorite: true // TEMP
            )
        )
    }

    var body: some View {
        StateHandler<DetailGameDomainModel>(
            state: detailPresenter.state,
            onLoad: loadData,
            loadingView: AnyView(ProgressView()),
            successView: { state in
                return AnyView(
                    DetailGameComponent(
                        game: game,
                        detail: state
                    )
                )
            }
        )
        .toolbar {
            ToolbarItem {
                HStack {
                    Text("") // To remove blue color.
                    StateHandler<FavoriteGameDomainModel>(
                        state: getFavoriteByIdPresenter.state,
                        onLoad: loadData,
                        loadingView: AnyView(ProgressView()),
                        successView: { state in
                            return AnyView(
                                FavoriteButton(
                                    favorite: FavoriteItem(
                                        isFavorite: state.isFavorite,
                                        onFavorite: onFavorite,
                                        width: 30,
                                        height: 30
                                    )
                                )
                            )
                        }
                    )
                }
            }
        }
    }
}
