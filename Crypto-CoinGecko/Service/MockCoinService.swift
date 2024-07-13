//
//  MockCoinService.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 6/7/24.
//

import Foundation

class MockCoinService: CoinServiceProtocol {
    var shouldReturnError = true
    func getCoins() async throws -> [Coin] {
        if shouldReturnError {
            throw CoinAPIError.invalidData
        } else {
            return [.init(id: "", symbol: "", name: "Demo", image: "demo", marketCapRank: 1)]
        }
        
    }
    
    func getCoinDetails(id: String) async throws -> CoinDetails? {
        return nil
    }
    
    
}
