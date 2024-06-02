//
//  Coin.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 22/5/24.
//

import Foundation

struct Coin: Codable, Identifiable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let marketCapRank: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case image
        case marketCapRank = "market_cap_rank"
    }
    
    static let exampleCoin = Coin(id: "1", symbol: "CoinSymbol", name: "CoinName", image: "Coin image URL", marketCapRank: 1)
}


struct CoinDetails: Codable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
}


struct Description: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
