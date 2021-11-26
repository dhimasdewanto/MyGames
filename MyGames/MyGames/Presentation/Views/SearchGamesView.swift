//
//  SearchGamesView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/11/21.
//

import SwiftUI
import Core
import Games

/// View for search games with search bar.
struct SearchGamesView: View {
    @EnvironmentObject var gamePresenter: GamePresenter

    @State private var searchText = ""
    @State private var isInitialSearch = true

    /// Load data from API.
    private func loadData() {
        if searchText == "" {
            isInitialSearch = true
            return
        }

        isInitialSearch = false

        self.gamePresenter.loadData(
            request: GameDomainRequest(
                page: 1,
                pageSize: 30,
                searchGame: searchText
            )
        )
    }

    /// Check if search result is not found.
    private func isNotFound() -> Bool {
        switch gamePresenter.state {
        case .success(let listData):
            if listData.isEmpty {
                return true
            }
            return false
        default:
            return false
        }
    }

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
            } else {
                Spacer()
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
                )
                Spacer()
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
