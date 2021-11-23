//
//  StateHandler.swift
//  MyGames
//
//  Created by TMLI IT Dev on 23/11/21.
//

import Core
import SwiftUI

struct StateHandler<T>: View {
    let state: ViewState<T>
    let onLoad: (() -> Void)
    let loadingView: AnyView
    let successView: ((T) -> AnyView)

    var body: some View {
        switch state {
        case .initial:
            Color.clear.onAppear(perform: onLoad)
        case .loading:
            loadingView
        case .error(let error):
            Text(error)
        case .success(let value):
            successView(value)
        }
    }
}
