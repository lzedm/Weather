//
//  TVDataSourceDelegate.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
            case weekForecastTV:
                return 7
            case fiveDayForecastTV:
                return 40
            default:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView{
            case weekForecastTV:
                let weekForecastTVCell = tableView.dequeueReusableCell(withIdentifier: WeekForecastTableViewCell.identifier, for: indexPath) as! WeekForecastTableViewCell
                if indexPath.row == 0{
                    weekForecastTVCell.dayLabel.text = "Сегодня"
                }else{
                    weekForecastTVCell.dayLabel.text = presenter.dailyArray[indexPath.row].dtString
                }
                weekForecastTVCell.weatherInfoLabel.text = presenter.dailyArray[indexPath.row].description
                weekForecastTVCell.iconImageView.image = UIImage(named: presenter.dailyArray[indexPath.row].icon)
                weekForecastTVCell.dayTemperatureLabel.text = presenter.dailyArray[indexPath.row].dayString
                weekForecastTVCell.nightTemperatureLabel.text = presenter.dailyArray[indexPath.row].nightString
                return weekForecastTVCell
            case fiveDayForecastTV:
                let fiveDayForecastTVCell = tableView.dequeueReusableCell(withIdentifier: FiveDayForecastTableViewCell.identifier, for: indexPath) as! FiveDayForecastTableViewCell
                fiveDayForecastTVCell.dayLabel.text = presenter.forecastArray[indexPath.row].dtString
                fiveDayForecastTVCell.weatherInfoLabel.text = presenter.forecastArray[indexPath.row].description
                fiveDayForecastTVCell.iconImageView.image = UIImage(named: presenter.forecastArray[indexPath.row].icon)
                fiveDayForecastTVCell.temperatureLabel.text = presenter.forecastArray[indexPath.row].tempString
                return fiveDayForecastTVCell
            default:
                fatalError("Unexpected row \(indexPath.row) in section \(indexPath.section)")
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
        
}
