//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 21/11/21.
//

import Foundation
import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
