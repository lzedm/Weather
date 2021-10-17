//
//  MainFirstCollectionViewCell.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import UIKit

class MainFirstCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainFirstCollectionViewCell"

    var hourlyCollectionView: UICollectionView!
    var infoCollectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setHourlyCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        hourlyCollectionView.delegate = dataSourceDelegate
        hourlyCollectionView.dataSource = dataSourceDelegate
        hourlyCollectionView.reloadData()
    }
    
    func setInfoCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        infoCollectionView.delegate = dataSourceDelegate
        infoCollectionView.dataSource = dataSourceDelegate
        infoCollectionView.reloadData()
    }
    
    var backHourlyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.addBlurEffect()
        return view
    }()
    
    var backInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.addBlurEffect()
        return view
    }()
    
    private func setLayout() {
        let layoutHourly: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutHourly.itemSize = CGSize(width: 55, height: 100)
        layoutHourly.sectionInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        layoutHourly.minimumLineSpacing = 0
        layoutHourly.scrollDirection = .horizontal
        
        hourlyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutHourly)
        hourlyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyCollectionView.showsHorizontalScrollIndicator = false
        hourlyCollectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        hourlyCollectionView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        hourlyCollectionView.layer.cornerRadius = 15
        hourlyCollectionView.isScrollEnabled = true
        hourlyCollectionView.backgroundView = backHourlyView
        contentView.isUserInteractionEnabled = false
        
        let infoLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        infoLayout.itemSize = CGSize(width: 90, height: 95)
        infoLayout.sectionInset = UIEdgeInsets(top: 20, left: 18.75, bottom: 20, right: 18.75)
        infoLayout.minimumLineSpacing = 18.75
        
        infoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: infoLayout)
        infoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        infoCollectionView.register(CurrentInfoCollectionViewCell.self, forCellWithReuseIdentifier: CurrentInfoCollectionViewCell.identifier)
        infoCollectionView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        infoCollectionView.layer.cornerRadius = 15
        infoCollectionView.isScrollEnabled = false
        infoCollectionView.backgroundView = backInfoView
        contentView.isUserInteractionEnabled = false

        let stack = UIStackView(arrangedSubviews: [hourlyCollectionView, infoCollectionView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 120),
            infoCollectionView.heightAnchor.constraint(equalToConstant: 365),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
        ])
    }
    
}
