//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Mustafa Bekirov on 16.04.2023.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    var model: WeatherModel {
        return WeatherModel(countryName: name,
                            temp: main.temp.toInt(),
                            conditionId: weather.first?.id ?? 0,
                            conditionDescription: weather.first?.description ?? "")
    }
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}

struct WeatherModel {
    
    let countryName: String
    let temp: Int
    let conditionId: Int
    let conditionDescription: String
    
    var conditionImage: String {
        switch conditionId {
            case 200...299:
                return "cloud.sun"
            case 300...399:
                return "cloud.drizzle"
            case 500...599:
                return "cloud.heavyrain"
            case 600...699:
                return "snowflake"
            case 700...799:
                return "smoke"
            case 800:
                return "wind"
            default:
                return "cloud"
        }
    }
}
