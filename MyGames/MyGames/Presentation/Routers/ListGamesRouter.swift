//
//  ListGamesRouter.swift
//  MyGames
//
//  Created by Dhimas Dewanto on 24/11/21.
//

import SwiftUI

class ListGamesRouter {
  func toDetail(for game: GamePresentationModel) -> some View {
      let detailPresenter = Injection.shared.provideDetailGame()
      let setFavoritePresenter = Injection.shared.provideSetFavorite()
      let getFavoriteByIdPresenter = Injection.shared.provideFavoriteById()

      return DetailPage(game: game)
          .environmentObject(detailPresenter)
          .environmentObject(setFavoritePresenter)
          .environmentObject(getFavoriteByIdPresenter)
  }
}
