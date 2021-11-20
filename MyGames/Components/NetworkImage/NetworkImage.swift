//
//  NetworkImage.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/08/21.
//

import SwiftUI

/// Extension to cache image if image already loaded.
extension EnvironmentValues {
    var imageCache: NetworkImageCache {
        get { self[NetworkImageKey.self] }
        set { self[NetworkImageKey.self] = newValue }
    }
}

/// Show image with internet address.
struct NetworkImage: View {
    /// Loader to load image with network.
    @StateObject private var loader: NetworkImageLoader
    /// Placeholder while loading image from internet.
    private let loadingHolder: AnyView

    init(
        urlAddress: String,
        loadingHolder: AnyView = AnyView(ProgressView())
    ) {
        self.loadingHolder = loadingHolder
        _loader = StateObject(
            wrappedValue: NetworkImageLoader(
                urlAddress: urlAddress,
                cache: Environment(
                    \.imageCache
                ).wrappedValue
            )
        )
    }

    var body: some View {
        Group {
            if loader.state == .error {
                Image(systemName: "photo.fill")
                    .foregroundColor(Color(UIColor.label))
            } else if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                loadingHolder
            }
        }.onAppear(perform: loader.load)
    }
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage(
            urlAddress: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg"
        )
        .scaledToFit()
    }
}
