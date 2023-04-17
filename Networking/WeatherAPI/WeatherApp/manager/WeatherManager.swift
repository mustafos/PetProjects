//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mustafa Bekirov on 16.04.2023.
//

import Foundation
import Alamofire

struct WeatherManager {
    
    private let API_KEY = "799edcc225a0d126028fc0e8e070243b"
    
    func fetchWeather(byCity city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let query = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        let path = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=metric"
        let urlString = String(format: path, city, API_KEY)
        
        AF.request(urlString).responseDecodable(of: WeatherData.self, queue: .main, decoder: JSONDecoder()) { (response) in
            switch response.result {
                case .success(let weatherData):
                    let model = weatherData.model
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
