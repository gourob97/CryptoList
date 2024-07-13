//
//  CoinDetailsCache.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 6/7/24.
//

import Foundation

class CoinDetailsCache {
    
    static let shared = CoinDetailsCache()
    
    private init() {}
    
    private let cache = NSCache<NSString, NSData>()

    func set(_ cointDetails: CoinDetails, forKey key: String) {
        guard let data = try? JSONEncoder().encode(cointDetails) else { return }
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    
    func get(forKey: String) -> CoinDetails? {
        guard let data = cache.object(forKey: forKey as NSString) as? Data else { return nil}
        return try? JSONDecoder().decode(CoinDetails.self, from: data)
    }
}
