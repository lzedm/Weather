//
//  HourlyWeatherModel.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import Foundation

struct HourlyWeatherModel{
    var temperature: Double
    var time: Int
    var icon: String

    init(hourlyWeatherData hourly: Hourly){
        self.temperature = hourly.temp
        self.time = hourly.dt
        self.icon = hourly.weather[0].icon
    }

    var temperatureString: String {
        let temp = String(format: "%.0f", temperature)
        return "\(temp)°"
    }

    var timeString: String {
        let convertedTime = Date(timeIntervalSince1970: TimeInterval(self.time))
        let df = DateFormatter()
        df.dateFormat = "HH"
        let time = df.string(from: convertedTime)
        return "\(time)"
    }

}
