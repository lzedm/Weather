//
//  File.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import Foundation
import UIKit

extension UIView{
    
    func addBlurEffect(){
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.clipsToBounds = true
            blurEffectView.layer.cornerRadius = 15
            self.addSubview(blurEffectView)
        }
}
