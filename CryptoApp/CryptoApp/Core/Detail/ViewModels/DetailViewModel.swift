//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Mustafa Bekirov on 01.08.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .sink { (returnedArrays) in
                print("REVIEVED COIN DETAIL DATA")
                print(returnedArrays)
            }
            .store(in: &cancellables)
    }
}
