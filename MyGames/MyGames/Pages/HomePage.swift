//
//  HomePage.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 14/08/21.
//

import SwiftUI

/// Page to show home page.
struct HomePage: View {
    var body: some View {
        TabView {
            NavigationView {
                ListGamesView()
            }
            .tabItem {
                Image(
                    systemName: "house")
                Text("Home")
            }

            NavigationView {
                SearchGamesView()
            }
            .tabItem {
                Image(
                    systemName: "magnifyingglass")
                Text("Search")
            }

            NavigationView {
                FavoriteGamesView()
            }
            .tabItem {
                Image(
                    systemName: "star")
                Text("Favorite")
            }

            NavigationView {
                AboutView()
            }
            .tabItem {
                Image(
                    systemName: "person.crop.circle")
                Text("About")
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()

    }
}