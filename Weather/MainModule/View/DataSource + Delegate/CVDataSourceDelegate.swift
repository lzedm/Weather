//
//  CVDataSourceDelegate.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainCV:
            let count = 3
            pageControl.numberOfPages = count
            return count
        case hourlyForecastCV:
            return 24
        case currentInfoCV:
            return 9
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainCV:
            switch indexPath.item {
                case 0:
                 let mainFirstCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainFirstCollectionViewCell.identifier, for: indexPath) as! MainFirstCollectionViewCell
                mainFirstCVCell.setHourlyCollectionViewDataSourceDelegate(dataSourceDelegate: self)
                mainFirstCVCell.setInfoCollectionViewDataSourceDelegate(dataSourceDelegate: self)
                hourlyForecastCV = mainFirstCVCell.hourlyCollectionView
                currentInfoCV = mainFirstCVCell.infoCollectionView
              return mainFirstCVCell
            case 1:
                let mainSecondCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainSecondCollectionViewCell.identifier, for: indexPath) as! MainSecondCollectionViewCell
                mainSecondCVCell.setTableViewDataSourceDelegate(dataSourceDelegate: self)
                weekForecastTV = mainSecondCVCell.tableView
              return mainSecondCVCell
            case 2:
                let mainThirdCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainThirdCollectionViewCell.identifier, for: indexPath) as! MainThirdCollectionViewCell
                mainThirdCVCell.setTableViewDataSourceDelegate(dataSourceDelegate: self)
                fiveDayForecastTV = mainThirdCVCell.tableView
              return mainThirdCVCell
            default:
                fatalError("Unexpected row \(indexPath.row) in section \(indexPath.section)")
            }
        case hourlyForecastCV:
            let hourlyForecastCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as! HourlyForecastCollectionViewCell
            if presenter.hourlyArray.isEmpty == false{
                hourlyForecastCVCell.temperatureLabel.text = presenter.hourlyArray[indexPath.row].temperatureString
            if indexPath.row == 0{
                hourlyForecastCVCell.hourLabel.text = "Now"
            }else{
                hourlyForecastCVCell.hourLabel.text = presenter.hourlyArray[indexPath.row].timeString
            }
                hourlyForecastCVCell.weatherIcon.image = UIImage(named: presenter.hourlyArray[indexPath.row].icon)
            }
            return hourlyForecastCVCell
        case currentInfoCV:
            let currentInfoCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentInfoCollectionViewCell.identifier, for: indexPath) as! CurrentInfoCollectionViewCell
            currentInfoCVCell.imageView.image = imageArray[indexPath.row]
            currentInfoCVCell.infoLabel.text = presenter.currentWeatherModel?.collectionInfoArray[indexPath.row]
            return currentInfoCVCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView{
        case mainCV:
            hourlyForecastCV?.isScrollEnabled = true
            pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        case hourlyForecastCV:
            mainCV?.isScrollEnabled = true
        default:
            break
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        switch scrollView{
        case mainCV:
            pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        default:
            break
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        switch scrollView{
        case mainCV:
            hourlyForecastCV?.isScrollEnabled = false
        case hourlyForecastCV:
            mainCV?.isScrollEnabled = false
        default:
            break
        }
    }
    
}
