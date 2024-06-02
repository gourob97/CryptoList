//
//  CoinAPIError.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 22/5/24.
//

import Foundation

enum CoinAPIError: Error {
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Invalid Data"
        case .jsonParsingFailure:
            return "Failed to parse json"
        case .requestFailed(description: let description):
            return "Request failed. \(description)"
        case .invalidStatusCode(statusCode: let statusCode):
            return "Invalid status code \(statusCode)"
        case .unknownError(error: let error):
            return "An unknwon error occured. \(error.localizedDescription)"
        }
    }
}
