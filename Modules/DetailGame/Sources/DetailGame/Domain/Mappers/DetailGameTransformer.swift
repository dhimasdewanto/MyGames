//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 23/11/21.
//

import Core

public struct DetailGameTransformer: Mapper {
    
    public typealias RequestData = DetailGameDataRequest
    
    public typealias RequestDomain = DetailGameDomainRequest
    
    public typealias ResponseData = DetailGameResponse
    
    public typealias ResponseDomain = DetailGameDomainModel
    
    public init() {}
    
    public func requestToData(_ request: DetailGameDomainRequest?) -> DetailGameDataRequest? {
        guard let req = request else {
            return nil
        }
        return DetailGameDataRequest(gameId: req.gameId)
    }
    
    public func requestToDomain(_ request: DetailGameDataRequest?) -> DetailGameDomainRequest? {
        guard let req = request else {
            return nil
        }
        return DetailGameDomainRequest(gameId: req.gameId)
    }
    
    public func responseToData(_ response: DetailGameDomainModel) -> DetailGameResponse {
        return DetailGameResponse(
            gameId: response.gameId,
            name: response.name,
            description: response.description,
            released: response.released,
            metacritic: response.metacritic,
            backgroundImage: response.backgroundImage
        )
    }
    
    public func responseToDomain(_ response: DetailGameResponse) -> DetailGameDomainModel {
        return DetailGameDomainModel(
            gameId: response.gameId,
            name: response.name,
            description: self.processDescription(response.description),
            released: response.released,
            metacritic: response.metacritic,
            backgroundImage: response.backgroundImage
        )
    }
    
    /// Process description text to remove html or markup tags.
    private func processDescription(_ description: String?) -> String? {
        guard let desc = description else {
            return nil
        }
        
        return desc
            .replacingOccurrences(of: "\n", with: "\n\n")
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<br/>", with: "")
            .replacingOccurrences(of: "<br />", with: "")
            .replacingOccurrences(of: "<br>", with: "")
            .replacingOccurrences(of: "<em>", with: "")
            .replacingOccurrences(of: "</em>", with: "")
            .replacingOccurrences(of: "<strong>", with: "")
            .replacingOccurrences(of: "</strong>", with: "")
            .replacingOccurrences(of: "<ul>", with: "")
            .replacingOccurrences(of: "</ul>", with: "")
            .replacingOccurrences(of: "<li>", with: "\n 💡 ")
            .replacingOccurrences(of: "</li>", with: "")
            .replacingOccurrences(of: "&#39;s", with: "'s")
            .replacingOccurrences(of: "<h1>", with: "")
            .replacingOccurrences(of: "</h1>", with: "")
            .replacingOccurrences(of: "<h2>", with: "")
            .replacingOccurrences(of: "</h2>", with: "")
            .replacingOccurrences(of: "<h3>", with: "")
            .replacingOccurrences(of: "</h3>", with: "")
            .replacingOccurrences(of: "<h4>", with: "")
            .replacingOccurrences(of: "</h4>", with: "")
            .replacingOccurrences(of: "<h5>", with: "")
            .replacingOccurrences(of: "</h5>", with: "")
            .replacingOccurrences(of: "<h6>", with: "")
            .replacingOccurrences(of: "</h6>", with: "")
    }
    
}
