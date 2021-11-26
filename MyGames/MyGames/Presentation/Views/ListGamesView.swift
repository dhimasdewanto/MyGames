//
//  ListGamesView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/08/21.
//

import SwiftUI
import Core
import Games

/// View for list games.
struct ListGamesView: View {
    @EnvironmentObject var gamePresenter: GamePresenter

    private func convertGameItems(_ listData: [GameDomainModel]) -> [GameItem] {
        return listData.map { data in
            GameItem(
                gameId: data.gameId,
                name: data.name,
                imageLocation: data.imageLocation,
                rating: data.rating,
                releaseDate: data.releaseDate
            )
        }
    }

    /// Load data from API.
    private func loadData() {
        gamePresenter.getList(
            request: GameDomainRequest(page: 1, pageSize: 30)
        )
    }

    var body: some View {
        StateHandler<[GameDomainModel]>(
            state: gamePresenter.state,
            onLoad: loadData,
            loadingView: AnyView(ProgressView()),
            successView: { state in
                return AnyView(
                    ListViewComponent(
                        listGames: convertGameItems(state)
                    )
                )
            }
        ).navigationTitle("Games")
    }
}

struct ListGamesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListGamesView()
        }
    }
}
