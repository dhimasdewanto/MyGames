//
//  DetailGameRepo.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 19/08/21.
//

import Foundation

/// Use singleton to avoid unnecessary new object.
let detailGameRepo: DetailGameRepo = DetailGameRepoImpl()

/// Interface of get API of detail game.
protocol DetailGameRepo {
    /// Get detail game from API from [gameId].
    func getDetailGame(
        gameId: Int,
        onUpdate: @escaping (DetailGameItem) -> Void
    )
}

/// Implementation of protocol [DetailGameRepo].
class DetailGameRepoImpl: UrlRepo, DetailGameRepo {
    func getDetailGame(
        gameId: Int,
        onUpdate: @escaping (DetailGameItem) -> Void
    ) {
        let address = "\(Configs.mainUrl)/games/\(gameId)"
        guard let url = getUrl(
            address: address
        ) else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession
            .shared
            .dataTask(with: request) { data, _, _ in
                if let data = data {
                    if let decodedResponse =
                        try? JSONDecoder()
                        .decode(DetailGameResponse.self, from: data) {
                        DispatchQueue.main.async {
                            let result = decodedResponse
                            let description = self.processDescription(
                                description: result.description ?? ""
                            )
                            onUpdate(
                                DetailGameItem(
                                    gameId: "\(result.gameId ?? 0)",
                                    name: result.name ?? "",
                                    imageLocation: result.backgroundImage ?? "",
                                    description: description,
                                    metacritic: result.metacritic ?? 0,
                                    releaseDate: result.released ?? ""
                                )
                            )
                        }
                        return
                    }
                }
            }.resume()
    }

    /// Process description text to remove html or markup tags.
    private func processDescription(description: String) -> String {
        return description
            .replacingOccurrences(of: "\n", with: "\n\n")
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<br/>", with: "")
            .replacingOccurrences(of: "<br />", with: "")
            .replacingOccurrences(of: "<br>", with: "")
            .replacingOccurrences(of: "<em>", with: "")
            .replacingOccurrences(of: "</em>", with: "")
            .replacingOccurrences(of: "<strong>", with: "")
            .replacingOccurrences(of: "</strong>", with: "")
            .replacingOccurrences(of: "<ul>", with: "")
            .replacingOccurrences(of: "</ul>", with: "")
            .replacingOccurrences(of: "<li>", with: "\n 💡 ")
            .replacingOccurrences(of: "</li>", with: "")
            .replacingOccurrences(of: "&#39;s", with: "'s")
    }
}
