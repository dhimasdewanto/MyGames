//
//  AboutView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/08/21.
//

import SwiftUI

/// View to show creator profile.
struct AboutView: View {

    var body: some View {
        VStack {
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(
                    width: 150,
                    height: 150
                )
                .cornerRadius(200)
                .padding(.bottom, 10)

            Text(Configs.name)
                .font(.headline)
                .padding(.bottom, 5)

            Text(Configs.email)
                .font(.subheadline)
        }
        .navigationTitle("About")
    }

}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView()
        }
    }
}
