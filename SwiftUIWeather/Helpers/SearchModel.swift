//
//  SearchModel.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 30/05/23.
//

import Foundation
import MapKit

class SearchModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var locationResult: [SearchResult] = []
    
    static let completer = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        SearchModel.completer.delegate = self
        SearchModel.completer.region = MKCoordinateRegion(.world)
        SearchModel.completer.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll

    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        if completer.queryFragment != "" {
            locationResult = self.getCityList(completer.results)
        }
        else  {
            locationResult = []
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func getCityList(_ results: [MKLocalSearchCompletion]) -> [SearchResult] {
        var searchResults = [SearchResult]()
        for result in results {
            searchResults.append(SearchResult(city: result.title, country: result.subtitle))
        }
        return searchResults
    }
    

}
