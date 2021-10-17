//
//  Forecast.swift
//  Weather
//
//  Created by Dima Milosh on 16.10.21.
//

import Foundation

struct ForecastData: Decodable{
    let list: [List]
}

// MARK: - List
struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [FiveDayWeather]

    enum CodingKeys: String, CodingKey {
        case dt, main, weather
    }
}

// MARK: - Main
struct Main: Decodable {
    let temp: Double
}

// MARK: - Weather
struct FiveDayWeather: Decodable {
    let main: String
    let description: String
    let icon: String
}
