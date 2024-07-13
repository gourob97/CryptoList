//
//  CoinDetailsViewModel.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 2/6/24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let apiService: CoinServiceProtocol
    
    let coindId: String
    
    @Published var coinDetails: CoinDetails?
    
    
    init(apiService: CoinServiceProtocol, coindId: String) {
        self.apiService = apiService
        self.coindId = coindId
    }
    
    @MainActor
    func getCoinDetails() async {
        do {
            coinDetails = try await apiService.getCoinDetails(id: coindId)
        } catch {
            debugPrint("Error: \(error)")
        }
        
    }
}

