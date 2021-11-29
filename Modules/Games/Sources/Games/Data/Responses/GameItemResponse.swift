//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 21/11/21.
//

import Foundation

/// API response from get list games request.
public struct GameItemResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]
}

public struct Result: Codable {
    let gameId: Int?
    let name: String?
    let released: String?
    let rating: Double?
    let ratingTop: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case name, released, rating
        case gameId = "id"
        case ratingTop = "rating_top"
        case image = "background_image"
    }
}
