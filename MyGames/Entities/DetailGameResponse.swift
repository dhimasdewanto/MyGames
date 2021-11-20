//
//  DetailGameResponse.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 19/08/21.
//

import Foundation

/// API response from get detail game request.
struct DetailGameResponse: Codable {
    let gameId: Int?
    let name: String?
    let description: String?
    let released: String?
    let metacritic: Int?
    let backgroundImage: String?

    enum CodingKeys: String, CodingKey {
        case name, description, released, metacritic
        case gameId = "id"
        case backgroundImage = "background_image"
    }
}
