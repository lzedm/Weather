//
//  CVDataSourceDelegate.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
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
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainFirstCollectionViewCell.identifier, for: indexPath) as! MainFirstCollectionViewCell
                    cell.setHourlyCollectionViewDataSourceDelegate(dataSourceDelegate: self)
                    cell.setInfoCollectionViewDataSourceDelegate(dataSourceDelegate: self)
                hourlyForecastCV = cell.hourlyCollectionView
                currentInfoCV = cell.infoCollectionView
              return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainSecondCollectionViewCell.identifier, for: indexPath) as! MainSecondCollectionViewCell
                cell.setTableViewDataSourceDelegate(dataSourceDelegate: self)
                weekForecastTV = cell.tableView
              return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainThirdCollectionViewCell.identifier, for: indexPath) as! MainThirdCollectionViewCell
                cell.setTableViewDataSourceDelegate(dataSourceDelegate: self)
                fiveDayForecastTV = cell.tableView
              return cell
            default:
                fatalError("Unexpected row \(indexPath.row) in section \(indexPath.section)")
            }
        case hourlyForecastCV:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as! HourlyForecastCollectionViewCell
            return cell
        case currentInfoCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentInfoCollectionViewCell.identifier, for: indexPath) as! CurrentInfoCollectionViewCell
            cell.imageView.image = imageArray[indexPath.row]
            return cell
        default:
            return fatalError("Unexpected row \(indexPath.row) in section \(indexPath.section)") as! UICollectionViewCell
        }
    }
}
