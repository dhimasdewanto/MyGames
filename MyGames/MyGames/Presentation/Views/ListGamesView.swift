//
//  ListGamesView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/11/21.
//

import SwiftUI
import Core
import Games

/// View for list games.
struct ListGamesView: View {
    @EnvironmentObject var gamePresenter: GamePresenter

    private func convertGameItems(_ listData: [GameDomainModel]) -> [GamePresentationModel] {
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

    /// Load data from API.
    private func loadData() {
        gamePresenter.loadData(
            request: GameDomainRequest(page: 1, pageSize: 30)
        )
    }

    var body: some View {
        StateHandler<[GameDomainModel]>(
            state: gamePresenter.state,
            onLoad: loadData,
            loadingView: AnyView(ProgressView()),
            successView: { state in
                if state.isEmpty {
                    return AnyView(
                        Text("Game is Empty")
                    )
                }
                
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
