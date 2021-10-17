//
//  CLLocation.swift
//  Weather
//
//  Created by Dima Milosh on 16.10.21.
//

import Foundation
import CoreLocation

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
