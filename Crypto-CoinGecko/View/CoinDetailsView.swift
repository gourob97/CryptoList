//
//  CoinDetailsView.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 2/6/24.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    
    @ObservedObject var coinDetailsVM: CoinDetailsViewModel
    @State private var task: Task<(), Never>?
    
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailsVM = CoinDetailsViewModel(coindId: coin.id)
    }
    
    var body: some View {
        ScrollView{
            if let coinDetails = coinDetailsVM.coinDetails {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(coinDetails.name)
                            Text(coinDetails.symbol.uppercased())
                                .font(.subheadline)
                        }
                        .font(.headline)
                        Spacer()
                        OnlineImage(iconUrlString: coin.image)
                            .frame(width: 34)
                    }
                    Text(coinDetails.description.text)
                }
                .padding(.horizontal, 16)
            }
        }
        .task {
            await coinDetailsVM.getCoinDetails()
        }
    }
}

#Preview {
    CoinDetailsView(coin: .exampleCoin)
}
