//
//  WeatherViewModel.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 17/05/23.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    
    @Published var weatherApiResponse: WeatherAPIResponse?
    @Published var searchText: String = ""
    
    func fetchWeatherDetails(for location: String) {
        var urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?q=\(location)&appid=ae7afc6c780a1cc3dbe4b04e980b7a86&units=metric&cnt=6"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
         URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if error != nil {
                print(error ?? "No Data")
                return
            }
            else {
                guard let data = data else {
                    print("Invalid data")
                    return
                }
                print(data)
                let weatherApiResponse = try? JSONDecoder().decode(WeatherAPIResponse.self, from: data)
                if let weatherApiResponse = weatherApiResponse {
                    DispatchQueue.main.async {
                        self?.weatherApiResponse = weatherApiResponse
                    }
                }
            }
         }.resume()
    }
}
