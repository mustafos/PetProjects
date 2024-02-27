//
//  LoadServiceProtocol.swift
//  Proxy
//
//  Created by Mustafa Bekirov on 17.02.2023.
//

import Foundation

protocol LoadServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}
