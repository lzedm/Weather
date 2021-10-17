//
//  Router.swift
//  Weather
//
//  Created by Dima Milosh on 16.10.21.
//

import Foundation

enum Router {
    case getWeatherData(lat: Double, lon: Double)
    case getFiveDayForecast(lat: Double, lon: Double)
        
    var path: String {
        switch self {
        case .getWeatherData:
            return "/data/2.5/onecall"
        case .getFiveDayForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getWeatherData(let lat, let lon):
          return [URLQueryItem(name: "lat", value: "\(lat)"),
                  URLQueryItem(name: "lon", value: "\(lon)"),
                  URLQueryItem(name: "lang", value: "ru"),
                  URLQueryItem(name: "units", value: "metric"),
                  URLQueryItem(name: "exclude", value: "minutely,alert"),
                  URLQueryItem(name: "appid", value: "c0564c47ee0b8953f97b351fc211e59e")]
        case .getFiveDayForecast(let lat, let lon):
          return [URLQueryItem(name: "lat", value: "\(lat)"),
                  URLQueryItem(name: "lon", value: "\(lon)"),
                  URLQueryItem(name: "lang", value: "ru"),
                  URLQueryItem(name: "units", value: "metric"),
                  URLQueryItem(name: "exclude", value: "minutely,alert"),
                  URLQueryItem(name: "appid", value: "c0564c47ee0b8953f97b351fc211e59e")]
        }
      }
}
