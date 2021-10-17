//
//  Presenter.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import Foundation

protocol ViewProtocol: AnyObject{
    func success()
    func failure(error: Error)
    func setLocationLabel(city: String)
}

protocol ViewPresenterProtocol: AnyObject{
    init(view: ViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol)
    var weatherData: WeatherData? {get set}
    var forecastData: ForecastData? {get set}
}

class Presenter: ViewPresenterProtocol, LocationServiceDelegate{
    let view: ViewProtocol
    let networkService: NetworkServiceProtocol!
    let locationService: LocationServiceProtocol!
    
    var weatherData: WeatherData?
    var forecastData: ForecastData?
    
    required init(view: ViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
        self.locationService.delegate = self
        locationService.startUpdatingLocation()
    }
    
    func didUpdateLocation(){
        self.setUpView()
        self.showWeatherData()
        self.showFiveDayForecast()
    }
    
    func showWeatherData(){
        guard let location = locationService.getCurrentLocation() else {return}
        networkService.getWeatherData(router: Router.getWeatherData(lat: location.lat, lon: location.lon)) {[weak self] (result: Result<WeatherData, Error>) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                    case .success((let weatherData)):
                        self.weatherData = weatherData
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
    
    func showFiveDayForecast(){
        guard let location = locationService.getCurrentLocation() else {return}
        networkService.getWeatherData(router: Router.getFiveDayForecast(lat: location.lat, lon: location.lon)) {[weak self] (result: Result<ForecastData, Error>) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                    case .success(let forecastData):
                        self.forecastData = forecastData
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
    
    func setUpView(){
        view.setLocationLabel(city: "📍\(locationService.getCurrentLocation()!.city)")
    }

}
