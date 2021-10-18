//
//  OfflineLaunch.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import Foundation
import UIKit

fileprivate var launchingView: UIView?

extension ViewController {

    func startOfflineLaunching() {
        launchingView = UIView(frame: self.view.bounds)
        launchingView?.backgroundColor = .systemBackground
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "wifi.slash")
        launchingView?.addSubview(imageView)
    
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = "Weather Unavailable"
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .darkGray
        errorLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        launchingView?.addSubview(errorLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "The Weather app isn't connected to the internet. \nTo view weather, check your connection, then try again."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textAlignment = .center
        launchingView?.addSubview(descriptionLabel)
    
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(retryPressed), for: .touchUpInside)
        launchingView?.addSubview(button)
    
        self.view.addSubview(launchingView!)
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: launchingView!.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: launchingView!.centerYAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: launchingView!.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: errorLabel.topAnchor, constant: -15),
        
            descriptionLabel.centerXAnchor.constraint(equalTo: launchingView!.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 15),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 300),
        
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.centerXAnchor.constraint(equalTo: launchingView!.centerXAnchor),
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 45)
        
        ])
    }
    
    @objc func retryPressed() {
        if Reachability.isConnectedToNetwork() == true {
            launchingView?.removeFromSuperview()
            launchingView = nil
            startLaunching()
            presenter.startUpdatingLocation()
        }
    }
    
}
