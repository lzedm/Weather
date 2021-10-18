//
//  LocationService.swift
//  Weather
//
//  Created by Dima Milosh on 16.10.21.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol: AnyObject{
    func getCurrentLocation() -> Location?
    func startUpdatingLocation()
    var delegate: LocationServiceDelegate? {get set}
}

protocol LocationServiceDelegate: AnyObject{
    func didUpdateLocation()
    func didFailUpdateLocation(error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
    
    var locationManager = CLLocationManager()
    var currentLocation: Location?
    weak var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            location.placemark { [self] placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
                if placemark.locality != nil{
                currentLocation = Location(lat: location.coordinate.latitude, lon: location.coordinate.longitude, city: "\(placemark.locality!), \(placemark.country!)")
                }else{
                    currentLocation = Location(lat: location.coordinate.latitude, lon: location.coordinate.longitude, city: "\(placemark.administrativeArea!), \(placemark.country!)")
                }
            self.delegate?.didUpdateLocation()
                }
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailUpdateLocation(error: error)
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> Location? {
        guard let location = currentLocation else { return nil }
        return location
    }
}
