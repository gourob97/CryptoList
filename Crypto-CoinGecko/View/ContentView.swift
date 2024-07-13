//
//  ContentView.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 22/5/24.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import AlertToast

struct ContentView: View {
    let coinService: CoinServiceProtocol
    
    @StateObject private var coinVM: CoinsViewModel
    
    init(coinService: CoinServiceProtocol) {
        self.coinService = coinService
        self._coinVM =  StateObject(wrappedValue: CoinsViewModel(coinService: coinService))
    }
    
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
                    .onAppear {
                        if coin == coinVM.coins.last {
                            Task {
                                await coinVM.getCoins()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Coins")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Coin.self) { coin in
                CoinDetailsView(coin: coin, service: coinService)
            }
            .toast(isPresenting: $coinVM.showToast){
                AlertToast(type: .regular, title: coinVM.errorMessage)
                        
                        //Choose .hud to toast alert from the top of the screen
                        //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
                        
                        //Choose .banner to slide/pop alert from the bottom of the screen
                        //AlertToast(displayMode: .banner(.slide), type: .regular, title: "Message Sent!")
                    }
        }
        .task {
            await coinVM.getCoins()
        }
    }
}

#Preview {
    ContentView(coinService: CoinService())
}
