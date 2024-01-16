//
//  LocationManager.swift
//  ios-app-milio
//
//  Created by VLC on 10/26/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit
import CoreLocation

/// LocationManager
protocol LocationManagerDelegate: AnyObject{
    func didChangeAuthorization( didChangeAuthorization: LocationManager.DidChangeAuthorization)
    func didUpdateLocations( didUpdateLocations locations: LocationManager.LocationCoordinate)
}

extension LocationManager {
    
    enum DidChangeAuthorization {
        case notDetermined
        case authorizedAlways
    }
    struct LocationCoordinate {
        let latitude: Double
        let longitude: Double
        var countryCode: String?
        var address:String?
        init(latitude: Double, longitude: Double, countryCode: String? = nil, address: String? = nil) {
            self.latitude    = latitude
            self.longitude   = longitude
            self.countryCode = countryCode
            self.address     = address
            
        }
    }
}

class LocationManager: CLLocationManager, CLLocationManagerDelegate{
    weak private var locationManagerDelegate: LocationManagerDelegate?
    private let geoCoder = CLGeocoder()
    public func setupLocationManager(delegate: LocationManagerDelegate) {
        self.locationManagerDelegate = delegate
        self.delegate = self
        self.startMonitoringSignificantLocationChanges()
        self.pausesLocationUpdatesAutomatically = false
        self.distanceFilter = 5000
        self.activityType = .fitness
        self.desiredAccuracy = kCLLocationAccuracyKilometer
        self.allowsBackgroundLocationUpdates = false
    }
    public func updatingLocation(){
        let status = CLLocationManager.authorizationStatus()
        self.stopUpdatingLocation()
        didChangeAuthorization(status: status)
    }
    private func didChangeAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            requestWhenInUseAuthorization()
            locationManagerDelegate?.didChangeAuthorization(didChangeAuthorization: .notDetermined)
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
            locationManagerDelegate?.didChangeAuthorization(didChangeAuthorization: .authorizedAlways)
        @unknown default:
            break
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        didChangeAuthorization(status: status)
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            geoCoder.reverseGeocodeLocation(location) {[self] (placemarks, error) in
                let coordinate = location.coordinate
                var locationCoordinate: LocationManager.LocationCoordinate = .init(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                )
                if let currentLocPlacemark = placemarks?.first {
                    let address = (currentLocPlacemark.thoroughfare ?? "") + ", " +
                    (currentLocPlacemark.subLocality ?? "") + ", " +
                    (currentLocPlacemark.locality ?? "") + ", " +
                    (currentLocPlacemark.country ?? "")
                    locationCoordinate.countryCode = currentLocPlacemark.isoCountryCode
                    locationCoordinate.address = address
                }
                locationManagerDelegate?.didUpdateLocations(
                    didUpdateLocations: locationCoordinate
                )
            }
        }
    }
}
