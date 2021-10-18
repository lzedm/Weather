//
//  FiveDayForecastModel.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import Foundation

struct FiveDayForecastModel{
    let dt: Int
    let description: String
    let temp: Double
    let icon: String
    
    init(forecastData list: List){
        self.dt = list.dt
        self.description = list.weather[0].description
        self.temp = list.main.temp
        self.icon = list.weather[0].icon
    }
    
    var dtString: String{
        let convertedTime = Date(timeIntervalSince1970: TimeInterval(self.dt))
        let df = DateFormatter()
        df.dateFormat = "E, d MMMM HH:mm"
        let time = df.string(from: convertedTime).capitalized
        return "\(time)"
    }
    
    var tempString: String {
        let temp = String(format: "%.0f", temp)
        return "\(temp)°"
    }
        
}
