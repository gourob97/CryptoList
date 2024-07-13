//
//  Crypto_CoinGeckoApp.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 22/5/24.
//

import SwiftUI

@main
struct Crypto_CoinGeckoApp: App {
    let coinService = CoinService()
    var body: some Scene {
        WindowGroup {
            ContentView(coinService: coinService)
        }
    }
}
