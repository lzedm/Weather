//
//  WeatherInfoCollectionViewCell.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import UIKit

class CurrentInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentInfoCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "17"
        return label
    }()
    
    func setLayout() {
        let stack = UIStackView(arrangedSubviews: [imageView, infoLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        contentView.addSubview(stack)
 
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 57),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}



