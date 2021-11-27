//
//  ListGamesRouter.swift
//  MyGames
//
//  Created by Dhimas Dewanto on 24/11/21.
//

import SwiftUI

class ListGamesRouter {
  func toDetail(for game: GamePresentationModel) -> some View {
      let detailGamePresenter = Injection.shared.provideDetailGame()
      let setFavoriteGamePresenter = Injection.shared.provideSetFavorite()

      return DetailPage(game: game)
          .environmentObject(detailGamePresenter)
          .environmentObject(setFavoriteGamePresenter)
  }
}
