//
//  ListGamesRepo.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 15/08/21.
//

import Foundation

/// Use singleton to avoid unnecessary new object.
let listGamesRepo: ListGamesRepo = ListGamesRepoImpl()

/// Interface of get API of list games.
protocol ListGamesRepo {
    /// Get list games for home page or view.
    func getListGames(
        page: Int,
        pageSize: Int,
        onUpdate: @escaping ([GameItem]) -> Void
    )

    /// Get list games for search page or view.
    func getSearchGames(
        search: String,
        page: Int,
        pageSize: Int,
        onUpdate: @escaping ([GameItem]) -> Void
    )
}

/// Implementation of ListGamesRepo.
class ListGamesRepoImpl: UrlRepo, ListGamesRepo {
    func getListGames(
        page: Int,
        pageSize: Int,
        onUpdate: @escaping ([GameItem]) -> Void
    ) {
        let address = "\(Configs.mainUrl)/games"
        guard let url = getUrl(
            address: address,
            queryItems: [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "page_size", value: "\(pageSize)")
            ]
        ) else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        processRequest(
            urlRequest: request,
            onUpdate: { listGames in
                onUpdate(self.sortListGames(listGames))
            }
        )
    }

    func getSearchGames(
        search: String,
        page: Int,
        pageSize: Int,
        onUpdate: @escaping ([GameItem]) -> Void
    ) {
        let address = "\(Configs.mainUrl)/games"
        guard let url = getUrl(
            address: address,
            queryItems: [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "page_size", value: "\(pageSize)"),
                URLQueryItem(name: "search", value: "\(search)")
            ]
        ) else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        processRequest(
            urlRequest: request,
            onUpdate: { listGames in
                onUpdate(self.sortListGames(listGames))
            }
        )
    }

    /// Process URL request.
    private func processRequest(
        urlRequest: URLRequest,
        onUpdate: @escaping ([GameItem]) -> Void
    ) {
        URLSession
            .shared
            .dataTask(with: urlRequest) { data, _, _ in
                if let data = data {
                    if let decodedResponse =
                        try? JSONDecoder()
                        .decode(ListGamesResponse.self, from: data) {
                        DispatchQueue.main.async {
                            let listResults = decodedResponse.results
                            let listGames = listResults.map { result -> GameItem in
                                let game = GameItem(
                                    gameId: "\(result.gameId ?? 0)",
                                    name: result.name ?? "",
                                    imageLocation: result.image ?? "",
                                    rating: result.rating ?? 0,
                                    releaseDate: FormatDate.toDate(
                                        result.released
                                    )
                                )
                                return game
                            }
                            onUpdate(listGames)
                        }
                        return
                    }
                }
            }.resume()
    }

    /// Sort list games based on rating.
    private func sortListGames(_ currentGames: [GameItem]) -> [GameItem] {
        var games = currentGames
        games.sort { prev, next in
            prev.rating > next.rating
        }
        return games
    }
}
