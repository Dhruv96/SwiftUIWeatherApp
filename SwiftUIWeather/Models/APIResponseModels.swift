//
//  APIResponseModels.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 17/05/23.
//

import Foundation

struct WeatherAPIResponse: Codable {
    let city: City
    let list: [WeatherOfDay]
}

struct City: Codable {
    let name: String
    let country: String
}

struct WeatherOfDay: Codable, Identifiable {
    var id: UUID { UUID() }
    let temp: Temp
    let pressure: Double
    let humidity: Double
    let feels_like: Temp
    let weather: [Description]
    let gust: Double
    let dt: TimeInterval
}

struct Temp: Codable {
    let day: Double
    let night: Double
    let eve: Double
}

struct Description: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}


struct SearchResult: Hashable {
    let city: String
    let country: String
}
