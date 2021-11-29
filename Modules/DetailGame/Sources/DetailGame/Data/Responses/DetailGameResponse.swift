//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 22/11/21.
//

/// API response from get detail game request.
public struct DetailGameResponse: Codable {
    public let gameId: Int?
    public let name: String?
    public let description: String?
    public let released: String?
    public let metacritic: Int?
    public let backgroundImage: String?

    public enum CodingKeys: String, CodingKey {
        case name, description, released, metacritic
        case gameId = "id"
        case backgroundImage = "background_image"
    }
}
