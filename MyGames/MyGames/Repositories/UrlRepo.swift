//
//  UrlRepo.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/08/21.
//

import Foundation

/// Repository to process URL and queries.
class UrlRepo {
    /// Get URL with String [address] and assign API Key automatically.
    func getUrl(
        address: String,
        queryItems: [URLQueryItem]? = nil
    ) -> URL? {
        var queryItemsWithKey = queryItems ?? []
        queryItemsWithKey.append(URLQueryItem(name: "key", value: Configs.apiKey))

        guard var urlComponent = URLComponents(string: address) else {
            print("Invalid URL Components")
            return nil
        }

        urlComponent.queryItems = queryItemsWithKey
        return urlComponent.url
    }
}
