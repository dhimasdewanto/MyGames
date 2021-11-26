//
//  MetacriticView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 23/11/21.
//

import SwiftUI

struct MetacriticView: View {
    var metacritic: Int

    var body: some View {
        Section {
            HStack {
                Image("metacritic")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 120,
                        height: 30
                    )
                if metacritic == 0 {
                    Text("Not Reviewed Yet")
                        .foregroundColor(.black)
                } else {
                    Text("= \(metacritic)")
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal)
        .background(
            Color.white
        )
        .cornerRadius(10)
    }
}

struct MetacriticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MetacriticView(
                metacritic: 0
            )
        }
    }
}
