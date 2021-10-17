//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import Foundation

struct CurrentWeatherModel {
    let temperature: Double
    let temperatureInfo: String
    let sunrise: Int
    let sunset: Int
    let pressure: Int
    let clouds: Double
    let humidity: Double
    let feelsLike: Double
    let visibility: Double
    let windSpeed: Double
    let windDeg: Double
    
    
    init(weatherData current: Current){
        self.temperature = current.temp
        self.temperatureInfo = current.weather[0].description
        self.sunrise = current.sunrise
        self.sunset = current.sunset
        self.pressure = current.pressure
        self.clouds = current.clouds
        self.humidity = current.humidity
        self.feelsLike = current.feels_like
        self.visibility = current.visibility
        self.windSpeed = current.wind_speed
        self.windDeg = current.wind_deg
    }
    
    var temperatureString: String {
        let temp = String(format: "%.0f", temperature)
        return "\(temp)°"
    }
    
    var temperatureInfoString: String {
        return temperatureInfo.capitalizingFirstLetter()
    }
    
    var sunriseString: String {
        let convertedTime = Date(timeIntervalSince1970: TimeInterval(sunrise))
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        let time = df.string(from: convertedTime)
        return "\(time)"
    }
    
    var sunsetString: String {
        let convertedTime = Date(timeIntervalSince1970: TimeInterval(sunset))
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        let time = df.string(from: convertedTime)
        return "\(time)"
    }
    
    var cloudsString: String {
        let clouds = String(format: "%.0f", clouds)
        return "\(clouds) %"
    }
    
    var pressureString: String {
        let pressure = String(pressure)
        return "\(pressure) гПа"
    }
    
    var humidityString: String {
        let humidity = String(format: "%.0f", humidity)
        return "\(humidity)%"
    }
    
    var feelsLikeString: String {
        let feelsLike = String(format: "%.0f", feelsLike)
        return "\(feelsLike)°"
    }

    var visibilityString: String {
        let km = visibility/1000
        let visibility = String(format: "%.0f", km)
        return "\(visibility) км"
    }
    
    var windSpeedString: String {
        let mlTokm = windSpeed*3.529
        let speed = String(format: "%.0f", mlTokm)
        return "\(speed) км/ч"
    }
    
    var windDegString: String {
        switch windDeg {
        case 22.5...67.4:
            return "СВ"
        case 67.5...122.4:
            return "В"
        case 122.5...157.4:
            return "ЮВ"
        case 157.5...202.4:
            return "Ю"
        case 202.5...247.4:
            return "ЮВ"
        case 247.5...292.4:
            return "З"
        case 292.5...337.4:
            return "СЗ"
        default:
            return "C"
        }
    }
        
    lazy var collectionInfoArray = [sunriseString, sunsetString, cloudsString, feelsLikeString, pressureString, humidityString, visibilityString, windSpeedString, windDegString]
}
