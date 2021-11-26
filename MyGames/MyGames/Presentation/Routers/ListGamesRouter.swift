//
//  ListGamesRouter.swift
//  MyGames
//
//  Created by Dhimas Dewanto on 24/11/21.
//

import SwiftUI

class ListGamesRouter {
  func toDetail(for game: GamePresentationModel) -> some View {
      let presenter = Injection.shared.provideDetailGame()
      return DetailPage(game: game).environmentObject(presenter)
  }
}
