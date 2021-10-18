//
//  DailyWeatherModel.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import Foundation

struct DailyWeatherModel{
    let dt: Int
    let icon: String
    let description: String
    let day: Double
    let night: Double
    let max: Double
    let min: Double
    
    init(dailyWeatherData daily: Daily){
        self.dt = daily.dt
        self.icon = daily.weather[0].icon
        self.description = daily.weather[0].description
        self.day = daily.temp.day
        self.night = daily.temp.night
        self.max = daily.temp.max
        self.min = daily.temp.min
    }
    
    var dtString: String{
        let convertedTime = Date(timeIntervalSince1970: TimeInterval(self.dt))
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        let time = df.string(from: convertedTime).capitalized
        return "\(time)"
    }
    
    var dayString: String {
        let temp = String(format: "%.0f", day)
        return "\(temp)°"
    }
    
    var nightString: String {
        let temp = String(format: "%.0f", night)
        return "\(temp)°"
    }
    
    var maxString: String {
        let temp = String(format: "%.0f", max)
        return "\(temp)°"
    }
    
    var minSring: String {
        let temp = String(format: "%.0f", min)
        return "\(temp)°"
    }
    
}
