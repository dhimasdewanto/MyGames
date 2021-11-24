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
    @EnvironmentObject var gamePresenter: GetListPresenter<
        GameDomainRequest,
        GameDomainModel,
        Interactor<
            GameDomainRequest,
            [GameDomainModel],
            GameRepository<
                GameRemoteSource,
                GameTransformer
            >
        >
    >

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

    var body: some View {
        ZStack {
            if gamePresenter.isLoading {
                ProgressView()
            } else if gamePresenter.isError {
                Text("Error")
            } else if gamePresenter.list.isEmpty { // 1
                Text("Game currently not available")
            } else {
                ListViewComponent(
                    listGames: convertGameItems(gamePresenter.list)
                )
            }
        }.onAppear {
            if self.gamePresenter.list.count == 0 { // 2
                self.gamePresenter.getList(
                    request: GameDomainRequest(
                        page: 1,
                        pageSize: 30
                    )
                ) // 3
            }
        }
        .navigationTitle("Games")
    }
}

struct ListGamesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListGamesView()
        }
    }
}
