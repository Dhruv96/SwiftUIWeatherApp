//
//  CityViewModel.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 07/08/25.
//

import Foundation

class CityViewModel : ObservableObject  {
    @Published var name: String
    @Published var country: String
    @Published var timeInterval: TimeInterval?
    
    init(name: String, country: String, timeInterval: TimeInterval?) {
        self.name = name
        self.country = country
        self.timeInterval = timeInterval
    }
}

class WeatherStatsViewModel : ObservableObject  {
    @Published var humidity: Double
    @Published var pressure: Double
    @Published var gust: Double
    
    init(humidity: Double, pressure: Double, gust: Double) {
        self.humidity = humidity
        self.pressure = pressure
        self.gust = gust
    }
}

class WeatherForecastViewModel : ObservableObject  {
    @Published var urlString: String
    @Published var temp: Double
    @Published var description: String
    
    init(urlString: String, temp: Double, description: String) {
        self.urlString = urlString
        self.temp = temp
        self.description = description
    }
}

class NextDayViewModel: ObservableObject, Identifiable {
    var id = UUID()
    @Published var urlString: String
    @Published var temp: Double
    @Published var timeInterval: TimeInterval
    
    init(urlString: String, temp: Double, timeInterval: TimeInterval) {
        self.urlString = urlString
        self.temp = temp
        self.timeInterval = timeInterval
    }
    
}
