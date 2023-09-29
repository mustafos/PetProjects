//
//  Network.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-16.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://graphql.contentful.com/content/v1/spaces/l39hqq1h1o7w?access_token=hs15Xu-ncBruiJqzJaGoERESyT0E7rgbw9HOp5oeVqo")!)
}
