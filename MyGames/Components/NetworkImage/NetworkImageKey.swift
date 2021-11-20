//
//  NetworkImageKey.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 21/08/21.
//

import SwiftUI

/// Env key for [NetworkImage] component.
struct NetworkImageKey: EnvironmentKey {
    static let defaultValue = NetworkImageCache()
}
