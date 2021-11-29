//
//  ListComponent.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/11/21.
//

import SwiftUI

/// Component for list view of [GameItem].
struct ListViewComponent: View {
    let listGames: [GamePresentationModel]

    private func toDetailNavigation<Content: View>(
        game: GamePresentationModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        let router = ListGamesRouter()
        return NavigationLink(
            destination: router.toDetail(for: game)
        ) { content() }
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<listGames.count) { index in
                    let game = listGames[index]
                    toDetailNavigation(game: game) {
                        ListTileComponent(
                            game: game,
                            ranking: index + 1
                        )
                    }
                }
            }
        }
    }
}

struct ListComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListViewComponent(
                listGames: [
                    GamePresentationModel(
                        gameId: "3",
                        name: "Games C Games C Games C Games C",
                        imageLocation: "gtav",
                        rating: 1,
                        releaseDate: Date()
                    )
                ]
            )
        }
    }
}
