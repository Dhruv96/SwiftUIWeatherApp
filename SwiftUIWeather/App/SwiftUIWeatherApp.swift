//
//  SwiftUIWeatherApp.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

@main
struct SwiftUIWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(weatherVM: WeatherViewModel())
        }
    }
}
