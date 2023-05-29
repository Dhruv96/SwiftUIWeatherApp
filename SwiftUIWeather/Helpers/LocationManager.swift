//
//  LocationManager.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 29/05/23.
//

import Foundation
import CoreLocation

class LocationManager: ObservableObject {
    
    @Published var city: String = ""
    
    func searchCity(text: String) {
        guard !text.isEmpty else {
            return
        }
        
        let geoCoder = CLGeocoder()
        let location = text
        geoCoder.geocodeAddressString(location) { (placemark, error) in
            if error != nil {
                print(error!)
            }
            if placemark != nil {
               print(placemark)
               
            } else {
                print("Empty placemark")
            }
        }
    }
}
