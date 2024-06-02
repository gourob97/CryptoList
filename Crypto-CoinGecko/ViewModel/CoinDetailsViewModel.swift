//
//  CoinDetailsViewModel.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 2/6/24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    let apiService = CoinService()
    
    let coindId: String
    
    @Published var coinDetails: CoinDetails?
    
    
    init(coindId: String)  {
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

