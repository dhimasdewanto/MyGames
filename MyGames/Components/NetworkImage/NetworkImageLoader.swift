//
//  NetworkImageLoader.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/08/21.
//

import Combine
import Foundation
import SwiftUI

/// Loader for [NetworkImage].
class NetworkImageLoader: ObservableObject {
    @Published var image: UIImage?
    private static let processImageQueue = DispatchQueue(label: "process-image")

    var state = NetworkImageState.initial
    private var url: URL?
    private var cache: NetworkImageCache?

    private var cancellable: AnyCancellable?

    init(urlAddress: String, cache: NetworkImageCache? = nil) {
        guard let url = URL(string: urlAddress) else {
            print("INVALID URL")
            self.state = .error
            return
        }

        self.url = url
        self.cache = cache
    }

    deinit {
        cancel()
    }

    /// Load image.
    func load() {
        guard let url = self.url else {
            return
        }

        if state == .loading {
            return
        }

        if let image = cache?[url] {
            self.image = image
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cacheImage(image: $0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.processImageQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    /// Cancel load image if it's running.
    func cancel() {
        cancellable?.cancel()
        state = .cancelled
    }

    /// Start to load image.
    private func onStart() {
        state = .loading
    }

    /// Set status load image to finish.
    private func onFinish() {
        state = .success
    }

    /// Cache image from image result.
    private func cacheImage(image: UIImage?) {
        guard let url = self.url else {
            return
        }
        image.map { cache?[url] = $0 }
    }
}
