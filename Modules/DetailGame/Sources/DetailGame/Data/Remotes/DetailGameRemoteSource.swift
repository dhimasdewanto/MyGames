//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 22/11/21.
//

import Combine
import Core
import Foundation

public class DetailGameRemoteSource: RemoteDataSource {
    public typealias Request = DetailGameDataRequest
    public typealias Response = DetailGameResponse
    
    public init() {}
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<DetailGameResponse, Error> { completion in
            guard let gameId = request?.gameId else {
                return
            }
            
            let address = "\(Configs.mainUrl)/games/\(gameId)"
            guard let url = self.getUrl(
                address: address
            ) else {
                return
            }
            
            URLSession
                .shared
                .dataTask(with: url) { data, _, _ in
                    if let data = data {
                        if let decodedResponse =
                            try? JSONDecoder()
                            .decode(DetailGameResponse.self, from: data) {
                            DispatchQueue.main.async {
                                completion(.success(decodedResponse))
                            }
                        }
                    }
                }.resume()
        }.eraseToAnyPublisher()
    }
    
    /// Get URL with String [address] and assign API Key automatically.
    private func getUrl(
        address: String,
        queryItems: [URLQueryItem]? = nil
    ) -> URL? {
        var queryItemsWithKey = queryItems ?? []
        queryItemsWithKey.append(URLQueryItem(name: "key", value: Configs.apiKey))

        guard var urlComponent = URLComponents(string: address) else {
            print("Invalid URL Components")
            return nil
        }

        urlComponent.queryItems = queryItemsWithKey
        return urlComponent.url
    }
}
