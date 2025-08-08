//
//  WeatherViewModel.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 17/05/23.
//
// ae7afc6c780a1cc3dbe4b04e980b7a86

import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    // Expose only what the view needs
    @Published var cityViewModel: CityViewModel?
    @Published var todayForecast: WeatherForecastViewModel?
    @Published var statsViewModel: WeatherStatsViewModel?
    @Published var upcomingForecasts: [NextDayViewModel] = []
    @Published var searchText: String = ""
    @Published var errorMessage: String?

    func fetchWeatherDetails(for location: String) async {
        guard let url = buildURL(for: location) else {
            errorMessage = "Invalid URL."
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
        
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d"

            let firstDay = decoded.list.first

            self.cityViewModel = CityViewModel(
                name: decoded.city.name,
                country: decoded.city.country,
                timeInterval: firstDay?.dt
            )

            todayForecast = firstDay.flatMap { weatherOfDay in
                guard let firstWeather = weatherOfDay.weather.first else { return nil }
                return WeatherForecastViewModel(
                    urlString: "https://openweathermap.org/img/wn/\(firstWeather.icon)@2x.png",
                    temp: weatherOfDay.temp.day,
                    description: firstWeather.description
                )
            }
            self.statsViewModel = firstDay.map {
                WeatherStatsViewModel(
                    humidity: $0.humidity,
                    pressure: $0.pressure,
                    gust: $0.gust
                )
            }

            self.upcomingForecasts = Array(decoded.list.dropFirst()).compactMap { weatherOfDay in
                guard let firstWeather = weatherOfDay.weather.first else {
                    // Skip this item if no weather info available
                    return nil
                }
                return NextDayViewModel(
                    urlString: "https://openweathermap.org/img/wn/\(firstWeather.icon)@2x.png",
                    temp: weatherOfDay.temp.day,
                    timeInterval: weatherOfDay.dt
                )
            }

            self.errorMessage = nil
        } catch {
            print(error)
            self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
        }
    }

    private func buildURL(for location: String) -> URL? {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String  else {
            return nil
        }
        
        let base = "https://api.openweathermap.org/data/2.5/forecast/daily"
        var components = URLComponents(string: base)
        components?.queryItems = [
            URLQueryItem(name: "q", value: location),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "cnt", value: "6")
        ]
        return components?.url
    }
}


extension WeatherViewModel {
    static var mock: WeatherViewModel {
        let vm = WeatherViewModel()
        
        // Mock city info
        vm.cityViewModel = CityViewModel(
            name: "Mock City",
            country: "MC",
            timeInterval: Date().timeIntervalSince1970
        )
        
        // Mock today forecast
        vm.todayForecast = WeatherForecastViewModel(
            urlString: "https://openweathermap.org/img/wn/01d@2x.png",
            temp: 22.5,
            description: "Clear sky"
        )
        
        // Mock weather stats
        vm.statsViewModel = WeatherStatsViewModel(
            humidity: 55,
            pressure: 1013,
            gust: 5
        )
        
        // Mock upcoming forecasts
        vm.upcomingForecasts = [
            NextDayViewModel(urlString: "https://openweathermap.org/img/wn/02d@2x.png", temp: 20, timeInterval: Date().addingTimeInterval(86400).timeIntervalSince1970),
            NextDayViewModel(urlString: "https://openweathermap.org/img/wn/03d@2x.png", temp: 18, timeInterval: Date().addingTimeInterval(2*86400).timeIntervalSince1970),
            NextDayViewModel(urlString: "https://openweathermap.org/img/wn/04d@2x.png", temp: 19, timeInterval: Date().addingTimeInterval(3*86400).timeIntervalSince1970),
        ]
        
        return vm
    }
}
