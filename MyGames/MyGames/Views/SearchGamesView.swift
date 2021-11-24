//
//  SearchGamesView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/08/21.
//

import SwiftUI
import Core
import Games

/// View for search games with search bar.
struct SearchGamesView: View {
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

    @State private var searchText = ""
    @State private var isInitialSearch = true

    /// Load data from API.
    private func loadData() {
        if searchText == "" {
            isInitialSearch = true
            return
        }

        isInitialSearch = false

        self.gamePresenter.getList(
            request: GameDomainRequest(
                page: 1,
                pageSize: 30,
                searchGame: searchText
            )
        )
    }

    /// Check if search result is not found.
    private func isNotFound() -> Bool {
        return gamePresenter.list.isEmpty && !gamePresenter.isLoading
    }

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
        VStack {
            SearchBarComponent(
                text: $searchText,
                onCommit: loadData
            ).padding()

            if isInitialSearch {
                VStack {
                    Spacer()
                    Text("Enter Search")
                    Spacer()
                }
            } else if isNotFound() {
                VStack {
                    Spacer()
                    Text("Search Result Not Found")
                    Spacer()
                }
            } else if gamePresenter.isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                VStack {
                    Spacer()
                    ListViewComponent(
                        listGames: convertGameItems(gamePresenter.list)
                    )
                }
            }
        }
        .navigationTitle("Search Games")
    }
}

struct SearchGamesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchGamesView()
        }
    }
}
