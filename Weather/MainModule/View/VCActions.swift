//
//  File.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import Foundation
import UIKit

extension ViewController{

    @objc func menuPressed() {
        let alert = UIAlertController(title: "MENU", message: "Please Select an Option", preferredStyle: .actionSheet)
        let share = UIAlertAction(title: "Share", style: .default, handler: { action in
            self.sharePressed()
        })
        let refresh = UIAlertAction(title: "Refresh", style: .default, handler: {action in
            self.refreshPressed()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(share)
        alert.addAction(refresh)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func sharePressed(){
            let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
    }
    
    func refreshPressed(){
        if Reachability.isConnectedToNetwork() == true {
            startLoading()
            presenter.startUpdatingLocation()
        }else{
            showErrorAlert(title: ErrorMessage.network.title, message: ErrorMessage.network.body) { action in
                self.presenter.startUpdatingLocation()
            }
        }
    }
    
}
