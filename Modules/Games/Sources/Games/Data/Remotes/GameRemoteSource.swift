//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 21/11/21.
//

import Core
import Combine
import Foundation
    
public class GameRemoteSource: RemoteDataSource {
    public typealias Request = GameDataRequest
    public typealias Response = GameItemResponse
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<GameItemResponse, Error> { completion in
            guard let page = request?.page else {
                return
            }
            
            guard let pageSize = request?.pageSize else {
                return
            }
            
            let address = "\(Configs.mainUrl)/games"
            guard let url = self.getUrl(
                address: address,
                queryItems: [
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "page_size", value: "\(pageSize)")
                ]
            ) else {
                return
            }
            
            URLSession
                .shared
                .dataTask(with: url) { data, _, _ in
                    if let data = data {
                        if let decodedResponse =
                            try? JSONDecoder()
                            .decode(GameItemResponse.self, from: data) {
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
