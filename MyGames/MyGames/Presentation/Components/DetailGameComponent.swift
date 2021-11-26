//
//  DetailGameComponent.swift
//  MyGames
//
//  Created by TMLI IT Dev on 23/11/21.
//

import DetailGame
import SwiftUI
import SDWebImageSwiftUI

struct DetailGameComponent: View {
    let game: GameItem
    let detail: DetailGameDomainModel

    private func readDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    var body: some View {
        ScrollView {
            VStack {
                WebImage(
                    url: URL(string: detail.backgroundImage ?? "")
                )
                .resizable()
                .scaledToFit()

                Text(detail.name ?? "")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                    .padding(.horizontal)

                MetacriticView(
                    metacritic: detail.metacritic ?? 0
                )

                Text("Release Date:")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .padding(.horizontal)

                Text(self.readDate(game.releaseDate))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

                Text(
                    detail.description ?? ""
                )
                .padding()
            }
        }
    }
}

// struct DetailGameComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailGameComponent()
//    }
// }
