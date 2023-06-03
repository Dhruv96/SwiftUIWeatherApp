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
                    var x = print(result.city)
                    if result.city.contains(",") {
                        let res = result.city.split(separator: ",")
                        weatherVM.fetchWeatherDetails(for: String(res[0]))
                    }
                    else {
                        weatherVM.fetchWeatherDetails(for: result.city)
                    }
                    
                    isSearchResultsShowing.toggle()
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
