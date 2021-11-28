//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 21/11/21.
//

import Foundation
import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Void, Error>
    func get(coreId: String) -> AnyPublisher<Response, Error>
    func update(coreId: String, entity: Response) -> AnyPublisher<Void, Error>
}
