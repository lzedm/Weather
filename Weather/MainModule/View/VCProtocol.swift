//
//  VCProtocol.swift
//  Weather
//
//  Created by Dima Milosh on 16.10.21.
//

import Foundation
import UIKit

extension ViewController: ViewProtocol {
    
    func success() {
        mainCV.reloadData()
        hourlyForecastCV?.reloadData()
        currentInfoCV?.reloadData()
        stopLoading()

    }
    
    func failure(error: ErrorMessage) {
        showErrorAlert(title: error.title, message: error.body) { action in
            self.presenter.startUpdatingLocation()
        }
    }
    
    func setLocationLabel(city: String) {
        locationLabel.text = city
    }
    
    func setTemperatureLabel(temperature: String) {
        temperatureLabel.text = temperature
    }
    
    func setTemperatureInfoLabel(temperatureInfo: String) {
        temperatureInfoLabel.text = temperatureInfo
    }
    
    func setWeatherIcon(icon: String) {
        weatherIcon.image = UIImage(named: "01d")
    }
    
    func setMaxMinTempLabel(dayNight: String) {
        maxMinLabel.text = dayNight
    }
    
    func getMessage(letter: String) {
        message = letter
    }
}
