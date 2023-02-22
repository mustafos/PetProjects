//
//  LocalDataFetcher.swift
//  SOLID
//
//  Created by Mustafa Bekirov on 22.02.2023.
//

import Foundation

class LocalDataFetcher: NetworkDataFetcher {
    override func fetchGenericJSONData<T>(urlString: String, response: @escaping (T?) -> Void) where T : Decodable {
        guard let file = Bundle.main.url(forResource: urlString, withExtension: nil) else {
            print("Couldn't find \(urlString) in main bundle.")
            response(nil)
            return
        }
        
        let data = try? Data(contentsOf: file)
        
        let decoded = self.decodeJSON(type: T.self, from: data)
        response(decoded)
    }
}
