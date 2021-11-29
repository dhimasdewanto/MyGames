//
//  MyGamesApp.swift
//  MyGames
//
//  Created by Dhimas Dewanto on 20/11/21.
//

import SwiftUI

@main
struct MyGamesApp: App {
    var body: some Scene {
        let favoritePresenter = Injection.shared.provideFavorite()

        WindowGroup {
            HomePage()
                .environmentObject(favoritePresenter)
        }
    }
}
