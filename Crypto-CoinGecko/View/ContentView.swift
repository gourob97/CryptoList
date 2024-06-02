//
//  ContentView.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 22/5/24.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject private var coinVM = CoinsViewModel()
    var body: some View {
        NavigationStack {
            List(coinVM.coins) { coin in
                NavigationLink(value: coin) {
                    HStack(spacing: 20){
                        Text(coin.marketCapRank.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        OnlineImage(iconUrlString: coin.image)
                            .frame(width: 34)
                        VStack(alignment: .leading){
                            Text(coin.id.capitalized)
                                .fontWeight(.medium)
                            Text(coin.symbol.uppercased())
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
            .navigationBarTitle("Coins")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Coin.self) { coin in
                CoinDetailsView(coin: coin)
            }
        }
        .task {
            await coinVM.getCoins()
        }
    }
}

#Preview {
    ContentView()
}
