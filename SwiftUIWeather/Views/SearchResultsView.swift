//
//  SearchResultsView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 01/06/23.
//

import SwiftUI
import MapKit

struct SearchResultsView: View {
    var results: [SearchResult] = []
    @Binding var isSearchResultsShowing: Bool
    @ObservedObject var weatherVM: WeatherViewModel
    var body: some View {
        LazyVStack {
            ForEach(results, id: \.self) { result in
                VStack {
                    Text(result.city + ", \(result.country)")
                    Divider()
                }
                .onTapGesture {
                    Task {
                        let cityName: String
                        if result.city.contains(",") {
                            let parts = result.city.split(separator: ",")
                            cityName = String(parts[0])
                        } else {
                            cityName = result.city
                        }
                        
                        await weatherVM.fetchWeatherDetails(for: cityName)
                        isSearchResultsShowing = false
                    }
                }
                
            }
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(isSearchResultsShowing: .constant(false), weatherVM: WeatherViewModel())
    }
}
