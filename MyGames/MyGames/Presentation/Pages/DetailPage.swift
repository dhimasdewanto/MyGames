//
//  DetailPage.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 12/11/21.
//

import DetailGame
import SwiftUI
import SDWebImageSwiftUI
import Core

/// Page to show detail game.
struct DetailPage: View {
    let game: GamePresentationModel

    @EnvironmentObject var detailPresenter: DetailGamePresenter
    @EnvironmentObject var favoritePresenter: GetFavoriteGamesPresenter
    @EnvironmentObject var setFavoritePresenter: SetFavoriteGamePresenter
    @EnvironmentObject var getFavoriteByIdPresenter: GetFavoriteGameByIdPresenter<
        Interactor<
            String,
            FavoriteGameDomainModel,
            GetFavoriteGameByIdRepository<
                FavoriteGamesLocaleSource,
                GetFavoriteGameByIdTransformer
            >
        >
    >

    /// Load detail data from API.
    private func loadData() {
        detailPresenter.execute(
            request: DetailGameDomainRequest(
                gameId: game.gameId
            )
        )
    }

    /// Load is favorite.
    private func loadIsFavorite() {
        getFavoriteByIdPresenter.execute(
            request: game.gameId
        )
        favoritePresenter.execute(
            request: nil
        )
    }

    /// On click favorite button.
    private func onFavorite() {
        setFavoritePresenter.execute(
            request: FavoriteGameDomainRequest(
                gameId: game.gameId,
                name: game.name,
                imageLocation: game.imageLocation,
                rating: game.rating,
                releaseDate: game.releaseDate
            )
        )
        loadIsFavorite()
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
                    StateHandler<Bool>(
                        state: getFavoriteByIdPresenter.state,
                        onLoad: loadIsFavorite,
                        loadingView: AnyView(ProgressView()),
                        successView: { isFavorite in
                            return AnyView(
                                FavoriteButton(
                                    favorite: FavoriteItem(
                                        isFavorite: isFavorite,
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
