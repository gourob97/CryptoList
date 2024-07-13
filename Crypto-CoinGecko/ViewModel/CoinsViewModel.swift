//
//  CoinsViewModel.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 22/5/24.
//

import Foundation
import SwiftUI

class CoinsViewModel: ObservableObject {
    @Published var coins: [Coin] = []
    @Published var showToast = false
    @Published var errorMessage: String? {
        didSet {
            showToast = (errorMessage != nil)
        }
    }
    
    private let coinService: CoinServiceProtocol
    
    init(coinService: CoinServiceProtocol) {
        self.coinService = coinService
    } 
    
    @MainActor
    func getCoins() async {
        do {
            coins += try await coinService.getCoins()
        } catch {
            guard let apiError = error as? CoinAPIError else {
                errorMessage = CoinAPIError.unknownError(error: error).customDescription
                return
            }
            errorMessage = apiError.customDescription
        }
    }
}
