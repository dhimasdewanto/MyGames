//
//  GetFavoriteGameByIdPresenter.swift
//  MyGames
//
//  Created by TMLI IT Dev on 28/11/21.
//

import Core
import Combine
import Foundation

public class GetFavoriteGameByIdPresenter<Interactor: UseCase>: ObservableObject
where
Interactor.Request == String,
Interactor.Response == FavoriteGameDomainModel {
    public typealias Request = String

    public typealias Response = Bool

    private var cancellables: Set<AnyCancellable> = []

    private let _useCase: Interactor

    @Published public var state: ViewState<Response> = .initial

    public init(useCase: Interactor) {
        _useCase = useCase
    }

    public func execute(request: Request?) {
        self.state = .loading
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure = completion {
                    self.state = .success(false)
//                    self.state = .error(String(describing: completion))
                }
            } receiveValue: { data in
                self.state = .success(data.isFavorite)
            }
            .store(in: &cancellables)
    }
}
