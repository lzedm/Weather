//
//  MainSecondCollectionViewCell.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import UIKit

class MainSecondCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainSecondCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.addBlurEffect()
        return view
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = .white
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tableView.register(WeekForecastTableViewCell.self, forCellReuseIdentifier: WeekForecastTableViewCell.identifier)
        return tableView
    }()
    
    func setTableViewDataSourceDelegate(dataSourceDelegate: UITableViewDelegate & UITableViewDataSource) {
        tableView.delegate = dataSourceDelegate
        tableView.dataSource = dataSourceDelegate
        tableView.reloadData()
    }
    
    private func setLayout() {
        tableView.backgroundView = backView
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            tableView.heightAnchor.constraint(equalToConstant: 349)
           
        ])
    }
    
}
