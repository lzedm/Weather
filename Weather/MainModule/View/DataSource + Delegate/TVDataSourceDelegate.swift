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
                let cell = tableView.dequeueReusableCell(withIdentifier: WeekForecastTableViewCell.identifier, for: indexPath) as! WeekForecastTableViewCell
                return cell
            case fiveDayForecastTV:
                let cell = tableView.dequeueReusableCell(withIdentifier: FiveDayForecastTableViewCell.identifier, for: indexPath) as! FiveDayForecastTableViewCell
                return cell
            default:
                fatalError("Unexpected row \(indexPath.row) in section \(indexPath.section)")        }
            
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
        
}
