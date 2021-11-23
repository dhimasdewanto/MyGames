//
//  ListGamesRouter.swift
//  MyGames
//
//  Created by TMLI IT Dev on 24/11/21.
//

import SwiftUI

class ListGamesRouter {
  func toDetail(for game: GameItem) -> some View {
      let presenter = Injection.shared.provideDetailGame()
      return DetailPage(game: game).environmentObject(presenter)
  }
}
