//
//  HTTPDataDownloader.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 6/7/24.
//

import Foundation

protocol HTTPDataDownloader {
    func getData<T: Decodable>(as type: T.Type, endPoint: String) async throws -> T
}

extension HTTPDataDownloader {
    func getData<T: Decodable>(as type: T.Type, endPoint: String) async throws -> T {
        guard let url = URL(string: endPoint) else {
            throw CoinAPIError.requestFailed(description: "Bad URL")
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestFailed(description: "Request Failed")
        }
        
        guard (200...300).contains(httpResponse.statusCode) else {
            throw CoinAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
            
        } catch {
            throw CoinAPIError.jsonParsingFailure
        }
    }
}
