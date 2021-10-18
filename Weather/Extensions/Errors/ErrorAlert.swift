//
//  ErrorAlert.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import UIKit

extension UIViewController {
    func showErrorAlert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "Retry", style: .default, handler: handler)
        alert.addAction(retry)
        present(alert, animated: true, completion: nil)
    }
}
