//
//  SearchBarComponent.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/11/21.
//

import SwiftUI

/// Search bar component for search view.
struct SearchBarComponent: View {
    @Binding var text: String
    let onCommit: () -> Void

    @State private var isEditing = false

    private func onCancel() {
        self.text = ""
        isEditing = false
        dismissKeyboard()
    }

    /// Dismiss the keyboard.
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    var body: some View {
        HStack {
            TextField(
                "Search...",
                text: $text,
                onCommit: onCommit
            )
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .onTapGesture {
                isEditing = true
            }

            if isEditing {
                Button(action: onCancel) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
            }
        }
    }
}

struct SearchBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarComponent(
            text: .constant(""),
            onCommit: {}
        )
    }
}
