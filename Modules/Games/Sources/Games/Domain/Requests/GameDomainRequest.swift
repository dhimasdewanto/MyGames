//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 21/11/21.
//

public struct GameDomainRequest {
    public let page: Int
    public let pageSize: Int
    public let searchGame: String?
    
    public init(
        page: Int,
        pageSize: Int,
        searchGame: String? = nil
    ) {
        self.page = page
        self.pageSize = pageSize
        self.searchGame = searchGame
    }
}
