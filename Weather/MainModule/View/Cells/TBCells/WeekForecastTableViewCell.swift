//
//  DailyForecastTableViewCell.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import UIKit

class WeekForecastTableViewCell: UITableViewCell {
    
    static let identifier = "WeekForecastTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "01d")
        return imageView
    }()
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Today"
        return label
    }()
    
    var weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .lightText
        label.text = "Sunny"
        return label
    }()
    
    var dayTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .white
        label.text = "17"
        return label
    }()
    
    var nightTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .lightText
        label.text = "10"
        return label
    }()
    
    private func setLayout() {
        
        let infoStack = UIStackView(arrangedSubviews: [dayLabel, weatherInfoLabel])
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.axis = .vertical
        
        addSubview(iconImageView)
        addSubview(dayTemperatureLabel)
        addSubview(nightTemperatureLabel)
        addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            dayTemperatureLabel.trailingAnchor.constraint(equalTo: nightTemperatureLabel.leadingAnchor, constant: -10),
            dayTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayTemperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            dayTemperatureLabel.widthAnchor.constraint(equalToConstant: 30),
            
            nightTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nightTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nightTemperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            nightTemperatureLabel.widthAnchor.constraint(equalToConstant: 30),
            
            infoStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            infoStack.trailingAnchor.constraint(equalTo: dayTemperatureLabel.leadingAnchor, constant: -10),
            infoStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}

