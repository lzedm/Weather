//
//  Launch.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import Foundation
import UIKit

fileprivate var loadingView: UIView?
fileprivate var launchingView: UIView?

extension UIViewController {

    func startLoading() {
        loadingView = UIView(frame: self.view.bounds)
        loadingView?.backgroundColor = .systemBackground
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loadingView!.center
        activityIndicator.startAnimating()
        loadingView?.addSubview(activityIndicator)
        self.view.addSubview(loadingView!)
    }
    
    func startLaunching() {
        launchingView = UIView(frame: self.view.bounds)
        launchingView?.backgroundColor = .systemBackground
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "icon")
        launchingView?.addSubview(imageView)
        self.view.addSubview(launchingView!)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: launchingView!.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: launchingView!.centerYAnchor)
        ])
    }
    
    func stopLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
        launchingView?.removeFromSuperview()
        launchingView = nil
    }
    
}
