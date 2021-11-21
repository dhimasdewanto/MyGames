//
//  EditProfilePage.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 29/08/21.
//

import SwiftUI

/// Page to edit profile
struct EditProfilePage: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var onDefaultAlert = false

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    /// To open default confirm alert.
    private func onDefault() {
        onDefaultAlert = true
    }

    /// Process button Ok default.
    private func processDefault() {
        UserDefaults
            .standard
            .setValue(
                Configs.defaultName,
                forKey: Configs.keyName)
        UserDefaults
            .standard
            .setValue(
                Configs.defaultEmail,
                forKey: Configs.keyEmail)
        back()
    }

    /// On click save button.
    private func onSave() {
        UserDefaults
            .standard
            .setValue(name, forKey: Configs.keyName)
        UserDefaults
            .standard
            .setValue(email, forKey: Configs.keyEmail)
        back()
    }

    /// Back to previous view.
    private func back() {
        self.mode.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            Spacer()

            TextField("Name", text: $name)
                .padding()

            TextField("Email", text: $email)
                .padding()

            Spacer()

            HStack {
                Button(action: onDefault) {
                    Text("Default")
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 50,
                            maxHeight: 50
                        )
                }

                Button(action: onSave) {
                    Text("Save")
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 50,
                            maxHeight: 50
                        )
                }
                .foregroundColor(.white)
                .background(Color(UIColor(.accentColor)))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Edit Profile")
        .alert(isPresented: $onDefaultAlert) {
            Alert(
                title: Text("Confirmation"),
                message: Text("Set value to default?"),
                primaryButton: .default(
                    Text("Ok"),
                    action: processDefault
                ),
                secondaryButton: .cancel()
            )
        }
    }
}

struct EditProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfilePage()
        }

    }
}
