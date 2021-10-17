//
//  WeatherData.swift
//  Weather
//
//  Created by Dima Milosh on 16.10.21.
//

import Foundation

struct WeatherData: Decodable{
    var current: Current
    var hourly: [Hourly]
    var daily: [Daily]
}

//MARK: - Current Weather
struct Current: Decodable {
    let sunrise: Int
    let sunset: Int
    var temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Double
    let clouds: Double
    let visibility: Double
    let wind_speed: Double
    let wind_deg: Double
    let rain: Rain?
    var weather: [Weather]
    
}

struct Rain: Decodable {
    let the1h: Double?
    
    enum CodingKeys: String, CodingKey {
        case the1h = "1h"
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    var description: String
    let icon: String
}

//MARK: - Hourly Forecast
struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    var weather: [HourlyWeather]
}

struct HourlyWeather: Decodable{
    let icon: String
}

//MARK: - Daily Forecast
struct Daily: Decodable{
    let dt: Int
    let temp: Temp
    var weather: [DailyWeather]
}

struct Temp: Decodable {
    let day: Double
    let night: Double
    let max: Double
    let min: Double
}

struct DailyWeather: Decodable{
    let description: String
    let icon: String
}
