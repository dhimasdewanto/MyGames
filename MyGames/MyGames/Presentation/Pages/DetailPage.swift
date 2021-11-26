//
//  DetailPage.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 12/08/21.
//

import DetailGame
import SwiftUI
import SDWebImageSwiftUI

/// Page to show detail game.
struct DetailPage: View {
    let game: GameItem

//    private let handler = CatalogueHandler()

    @EnvironmentObject var detailPresenter: DetailGamePresenter

    /// Load detail data from API.
    private func loadData() {
        detailPresenter.getList(request: DetailGameDomainRequest(gameId: game.gameId))
    }

    /// Get is favorite from core data.
    private func getIsFavorite() -> Bool {
//        return handler.getIsFavorite(
//            coreGames: coreGames,
//            game: game
//        )
        return true
    }

    /// On click favorite button.
    private func onFavorite() {
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