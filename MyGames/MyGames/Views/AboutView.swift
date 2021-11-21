//
//  AboutView.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/08/21.
//

import SwiftUI

/// View to show creator profile.
struct AboutView: View {
    @AppStorage(Configs.keyName) var storageName: String = Configs.defaultName
    @AppStorage(Configs.keyEmail) var storageEmail: String = Configs.defaultEmail

    private let notification = Notification()

    private func sendNotification() {
        notification.sendNotification(
            title: "Hello \(storageName)!",
            subtitle: "From Notification"
        )
    }

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

            Text(storageName)
                .font(.headline)
                .padding(.bottom, 5)

            Text(storageEmail)
                .font(.subheadline)

            Button(
                action: sendNotification
            ) {
                Text("Hear Hello From Notification")
            }
            .padding()
        }
        .navigationTitle("About")
        .toolbar {
            NavigationLink(
                destination: EditProfilePage()
            ) {
                HStack {
                    Image(systemName: "pencil")
                    Text("Edit Profile")
                }
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView()
        }
    }
}
