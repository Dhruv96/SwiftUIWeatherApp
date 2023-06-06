//
//  LocationManager.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 29/05/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var city: String = ""
    
    override init()  {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            print("Not Determined")
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("Authorized Always")
        case .authorizedWhenInUse:
            print("Authorized When in use")
        @unknown default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("Error fetching locations...Location Nil")
            return
        }
        
        getUserCity(for: location) { [weak self] placemark in
            if let placemark = placemark, let locality = placemark.locality {
                print(locality)
                self?.city = locality
            }
            else {
                print("Something wrong")
            }
            self?.locationManager.stopUpdatingLocation()
        }
    }
}

extension LocationManager {
    func getUserCity(for location: CLLocation, completion: @escaping (CLPlacemark?) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print(error)
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
            
        }
    }
}
