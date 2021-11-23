//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 23/11/21.
//

import Foundation
import SwiftUI
import Combine

open class GetDataPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    
    @Published public var state: ViewState<Response> = .initial
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func getList(request: Request?) {
        self.state = .loading
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    self.state = .error(String(describing: completion))
                }
            }, receiveValue: { data in
                self.state = .success(data)
            })
            .store(in: &cancellables)
    }
}
