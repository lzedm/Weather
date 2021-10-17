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
    func setTemperatureInfoLabel(temperatureInfo: String)
    func setTemperatureLabel(temperature: String)
    func setWeatherIcon(icon: String)
    func setMaxMinTempLabel(dayNight: String)
}

protocol ViewPresenterProtocol: AnyObject{
    init(view: ViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol)
    var weatherData: WeatherData? {get set}
    var forecastData: ForecastData? {get set}
    var currentWeatherModel: CurrentWeatherModel? {get set}
    var hourlyWeatherModel: HourlyWeatherModel? {get set}
    var dailyWeatherModel: DailyWeatherModel? {get set}
    var fiveDayForecastModel: FiveDayForecastModel? {get set}
    var hourlyArray: [HourlyWeatherModel] {get set}
    var dailyArray: [DailyWeatherModel] {get set}
    var forecastArray: [FiveDayForecastModel] {get set}
    func didUpdateLocation()
}

class Presenter: ViewPresenterProtocol, LocationServiceDelegate{
    let view: ViewProtocol
    let networkService: NetworkServiceProtocol!
    let locationService: LocationServiceProtocol!
    
    var weatherData: WeatherData?
    var forecastData: ForecastData?
    var hourlyWeatherModel: HourlyWeatherModel?
    var currentWeatherModel: CurrentWeatherModel?
    var dailyWeatherModel: DailyWeatherModel?
    var fiveDayForecastModel: FiveDayForecastModel?
    var hourlyArray: [HourlyWeatherModel] = []
    var dailyArray: [DailyWeatherModel] = []
    var forecastArray: [FiveDayForecastModel] = []
    
    required init(view: ViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
        self.locationService.delegate = self
        locationService.startUpdatingLocation()
    }
    
    func didUpdateLocation(){
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
                        self.currentWeatherModel = CurrentWeatherModel(weatherData: weatherData.current)
                        for index in weatherData.hourly{ self.hourlyArray.append(HourlyWeatherModel(hourlyWeatherData: index))
                        }
                        for index in weatherData.daily{
                            self.dailyArray.append(DailyWeatherModel(dailyWeatherData: index))
                        }
                        self.setUpView()
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
                        for index in forecastData.list{
                            self.forecastArray.append(FiveDayForecastModel(forecastData: index))
                        }
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
    
    func setUpView(){
        view.setLocationLabel(city: "📍\(locationService.getCurrentLocation()!.city)")
        view.setTemperatureLabel(temperature: currentWeatherModel!.temperatureString)
        view.setTemperatureInfoLabel(temperatureInfo: currentWeatherModel!.temperatureInfoString)
        view.setWeatherIcon(icon: hourlyArray[0].icon)
        view.setMaxMinTempLabel(dayNight: ("\(dailyArray[0].maxString) / \(dailyArray[0].minSring)"))
    }

}
