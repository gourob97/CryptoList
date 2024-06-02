//
//  OnlineImage.swift
//  Crypto-CoinGecko
//
//  Created by Gourob Mazumder on 2/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnlineImage: View {
    let iconUrlString: String
    var body: some View {
        if let iconUrl = URL(string: iconUrlString) {
            WebImage(url: iconUrl) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    OnlineImage(iconUrlString: "https://coin-images.coingecko.com/coins/images/1/thumb/bitcoin.png?1696501400")
}
