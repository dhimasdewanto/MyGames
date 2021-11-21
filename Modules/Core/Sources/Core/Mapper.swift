//
//  Mapper.swift
//  
//
//  Created by Dhimas Dewanto on 21/11/21.
//

import Foundation

public protocol Mapper {
    associatedtype RequestData
    associatedtype RequestDomain
    associatedtype ResponseData
    associatedtype ResponseDomain
    
    func requestToData(_ request: RequestDomain?) -> RequestData?
    func requestToDomain(_ request: RequestData?) -> RequestDomain?
    func responseToData(_ response: ResponseDomain) -> ResponseData
    func responseToDomain(_ response: ResponseData) -> ResponseDomain
}

