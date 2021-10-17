//
//  MainVCProtocol.swift
//  Weather
//
//  Created by Dima Milosh on 16.10.21.
//

import Foundation
import UIKit

extension ViewController: ViewProtocol {
    
    func success() {
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func setLocationLabel(city: String) {
        locationLabel.text = city
    }
    
        
}
