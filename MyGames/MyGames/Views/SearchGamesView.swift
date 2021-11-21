//
//  SearchGamesView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/08/21.
//

import SwiftUI

/// View for search games with search bar.
struct SearchGamesView: View {
    @State private var listGames = [GameItem]()
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var isInitialSearch = true

    /// Load data from API.
    private func loadData() {
        if searchText == "" {
            isInitialSearch = true
            return
        }

        isSearching = true
        isInitialSearch = false
        listGamesRepo.getSearchGames(
            search: searchText,
            page: 1,
            pageSize: 30,
            onUpdate: { listGames in
                self.listGames = listGames
                isSearching = false
            }
        )
    }

    /// Check if search result is not found.
    private func isNotFound() -> Bool {
        return listGames.isEmpty && !isSearching
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
            } else if isSearching {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                VStack {
                    Spacer()
                    ListViewComponent(
                        listGames: listGames)
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
