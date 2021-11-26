//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 21/11/21.
//

import Foundation
import Core

public struct GameTransformer: Mapper {
    public typealias RequestData = GameDataRequest
    
    public typealias RequestDomain = GameDomainRequest
    
    public typealias ResponseData = GameItemResponse
    
    public typealias ResponseDomain = [GameDomainModel]
    
    public init() {}
    
    public func requestToData(_ request: GameDomainRequest?) -> GameDataRequest? {
        guard let data = request else {
            return nil
        }
        return GameDataRequest(
            page: data.page,
            pageSize: data.pageSize,
            searchGame: data.searchGame
        )
    }
    
    public func requestToDomain(_ request: GameDataRequest?) -> GameDomainRequest? {
        guard let data = request else {
            return nil
        }
        return GameDomainRequest(
            page: data.page,
            pageSize: data.pageSize,
            searchGame: data.searchGame
        )
    }
    
    public func responseToData(_ response: [GameDomainModel]) -> GameItemResponse {
        return GameItemResponse(count: nil, next: nil, previous: nil, results: [])
    }
    
    public func responseToDomain(_ response: GameItemResponse) -> [GameDomainModel] {
        return response.results.map { data in
            return GameDomainModel(
                gameId: "\(data.gameId ?? 0)",
                name: data.name ?? "",
                imageLocation: data.image ?? "",
                rating: data.rating ?? 0,
                releaseDate: self.toDate(data.released)
            )
        }
    }
    
    private func toDate(_ dateString: String?) -> Date {
        guard let dateString = dateString else {
            return Date()
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
}
