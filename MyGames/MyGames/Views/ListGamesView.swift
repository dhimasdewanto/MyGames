//
//  ListGamesView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/08/21.
//

import SwiftUI

/// View for list games.
struct ListGamesView: View {
    @State private var listGames = [GameItem]()

    private func loadData() {
        listGamesRepo.getListGames(
            page: 1,
            pageSize: 30,
            onUpdate: { listGames in
                self.listGames = listGames
            }
        )
    }

    var body: some View {
        Section {
            if listGames.isEmpty {
                ProgressView()
                    .onAppear(perform: loadData)
            } else {
                ListViewComponent(
                    listGames: listGames
                )
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
