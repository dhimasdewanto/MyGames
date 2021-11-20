//
//  FormatDate.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 29/08/21.
//

import Foundation

class FormatDate {
    static func toString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    static func toDate(_ dateString: String?) -> Date {
        guard let dateString = dateString else {
            return Date()
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
}
