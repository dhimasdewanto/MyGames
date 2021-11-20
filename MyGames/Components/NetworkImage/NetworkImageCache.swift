//
//  NetworkImageCache.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 18/08/21.
//

import SwiftUI

/// Struct to cache [NetworkImage].
struct NetworkImageCache {
    private let cache = NSCache<NSURL, UIImage>()

    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }

        set { newValue == nil ?
            cache.removeObject(forKey: key as NSURL) :
            cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
