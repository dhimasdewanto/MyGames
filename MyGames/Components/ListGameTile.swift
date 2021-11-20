//
//  ListTileComponent.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/08/21.
//

import SwiftUI

struct ListGameTile: View {
    var game: GameItem

    private func getStringDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }

    var body: some View {
        HStack {
            ZStack(
                alignment: .bottomLeading
            ) {
                Image(game.imageLocation)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: 120,
                        height: 100
                    )
                    .cornerRadius(10)
                    .clipped()

                Text("\(game.rating)")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(7)
                    .padding(.all, 7)
            }

            VStack(alignment: .leading) {
                Text(game.name)
                    .padding()

                Text(getStringDate(game.releaseDate))
                    .font(.caption)
                    .padding()
            }
        }
    }
}
