//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mustafa Bekirov on 16.07.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
