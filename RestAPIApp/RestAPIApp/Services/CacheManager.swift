//
//  CacheManager.swift
//  RestAPIApp
//
//  Created by dzmitry on 2.01.23.
//

import Foundation
import AlamofireImage

final class CacheManager {
    private init() {}
    
    static let shared = CacheManager() // синглтон
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
