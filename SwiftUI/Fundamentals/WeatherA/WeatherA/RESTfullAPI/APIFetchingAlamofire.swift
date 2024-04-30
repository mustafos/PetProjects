//
//  APIFetchingAlamofire.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 21.04.2024.
//

import Foundation
import Alamofire

final class NetworkAlamofireManager: ObservableObject {
    static let shared = NetworkAlamofireManager()
    
    private init() {}
    
    func fetchEmployees(from url: URL, completion: @escaping(Result<[Employee], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                case .success(let correctData):
                    let employees = self.parseEmployees(correctData)
                    completion(.success(employees))
                case .failure(let afError):
                    print("AF error: \(afError.localizedDescription)")
                    if responseData.response?.statusCode == 429 {
                        completion(.failure(.tooManyRequests))
                    } else {
                        completion(.failure(.noData))
                    }
                }
            }
    }
    
    private func parseEmployees(_ data: Data) -> [Employee] {
        var employees = [Employee]()
        if let decoded: Query = decode(data) {
            employees = decoded.data
        }
        return employees
    }
}
