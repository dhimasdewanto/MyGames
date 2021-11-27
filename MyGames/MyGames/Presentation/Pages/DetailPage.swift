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

//    private let handler = CatalogueHandler()

    @EnvironmentObject var detailPresenter: DetailGamePresenter
    @EnvironmentObject var setFavoritePresenter: SetFavoriteGamePresenter

    /// Load detail data from API.
    private func loadData() {
        detailPresenter.execute(
            request: DetailGameDomainRequest(
                gameId: game.gameId
            )
        )
    }

    /// Get is favorite from core data.
    private func getIsFavorite() -> Bool {
//        return handler.getIsFavorite(
//            coreGames: coreGames,
//            game: game
//        )
        return false
    }

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
//        handler.setIsFavorite(
//            context: managedObjectContext,
//            coreGames: coreGames,
//            game: game
//        )
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
                    FavoriteButton(
                        favorite: FavoriteItem(
                            isFavorite: getIsFavorite(),
                            onFavorite: onFavorite,
                            width: 30,
                            height: 30
                        )
                    )
                }
            }
        }
    }
}
