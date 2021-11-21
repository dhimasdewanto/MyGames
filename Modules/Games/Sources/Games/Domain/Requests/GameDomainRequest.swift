//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 21/11/21.
//

public struct GameDomainRequest {
    public var page: Int
    public var pageSize: Int
    
    public init(page: Int, pageSize: Int) {
        self.page = page
        self.pageSize = pageSize
    }
}
