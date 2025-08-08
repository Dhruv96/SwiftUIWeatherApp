//
//  ContentView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherVM: WeatherViewModel = WeatherViewModel()
    @StateObject var searchModel = SearchModel()
    @State var isSearchResultsShowing = false
    
    let row = GridItem(.fixed(10), spacing: 8, alignment: .leading)
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    SearchView(searchText: $weatherVM.searchText, isSearchResultsShowing: $isSearchResultsShowing, weatherVM: weatherVM)
                        .padding(.top, 48)
                        .environmentObject(searchModel)
                    
                    if isSearchResultsShowing {
                        SearchResultsView(results: searchModel.locationResult, isSearchResultsShowing: $isSearchResultsShowing, weatherVM: weatherVM)
                            .background(Color.black.opacity(0.5))
                            .padding(.top, -20)
                    }
                    else {
                        
                        if let city = weatherVM.cityViewModel {
                            CityView(cityVM: city)
                        }
                        
                        if let today = weatherVM.todayForecast {
                            WeatherDescriptionView(weatherForecastVM: today)
                        }
                        if let stats = weatherVM.statsViewModel {
                            WeatherElementView(weatherAttribute: "Humidity", weatherAttributeVal: stats.humidity)
                            WeatherElementView(weatherAttribute: "Pressure", weatherAttributeVal: stats.pressure)
                            WeatherElementView(weatherAttribute: "Gusts", weatherAttributeVal: stats.gust)
                        }
                    
                        if !weatherVM.upcomingForecasts.isEmpty {
                            
                            Text("Next 5 Days")
                                .padding(.leading, 16)
                                .padding(.top, 16)
                                .padding(.bottom, 8)
                            
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [row], spacing: 0) {
                                    ForEach(weatherVM.upcomingForecasts) { day in
                                        NextDayView(nextDayVM: day)
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                .preferredColorScheme(.dark)
            }
            .background {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 155/255), Color.blue, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherVM: WeatherViewModel())
                   
    }
}
