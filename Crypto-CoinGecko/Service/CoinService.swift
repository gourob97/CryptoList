//
//  CoinService.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 22/5/24.
//

import Foundation
protocol CoinServiceProtocol {
    func getCoins() async throws -> [Coin]
    func getCoinDetails(id: String) async throws -> CoinDetails?
}

class CoinService: CoinServiceProtocol, HTTPDataDownloader {
    var page = 0
    var pageLimit = 30
    
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
        return components
    }
    
    private var allCoinsUrlString: String? {
        var components = baseUrlComponents
        components.path += "markets"
        components.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "per_page", value: "\(pageLimit)"),
            .init(name: "page", value: "\(page)")
        ]
        return components.url?.absoluteString
    }
    
    private func coinDetailsUrlString(id: String) -> String? {
        var components = baseUrlComponents
        components.path += id
        components.queryItems = [
            .init(name: "localization", value: "false")
        ]
        return components.url?.absoluteString
    }
    
    func getCoins() async throws -> [Coin]  {
        page += 1
        guard let allCoinsUrlString = allCoinsUrlString else {
            throw CoinAPIError.requestFailed(description: "URL error")
        }
        return try await getData(as: [Coin].self, endPoint: allCoinsUrlString)
    }
    
    func getCoinDetails(id: String) async throws -> CoinDetails? {
        if let cache = CoinDetailsCache.shared.get(forKey: id) {
            return cache
        }
        guard let coinDetailsUrlString = coinDetailsUrlString(id: id) else {
            throw CoinAPIError.requestFailed(description: "URL error")
        }
        let details =  try await getData(as: CoinDetails.self, endPoint: coinDetailsUrlString)
        CoinDetailsCache.shared.set(details, forKey: id)
        return details
    }
}
