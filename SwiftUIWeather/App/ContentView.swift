//
//  ContentView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherVM: WeatherViewModel = WeatherViewModel()
    
    let row = GridItem(.fixed(180), spacing: 10, alignment: .leading)
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                SearchView(searchText: $weatherVM.searchText, weatherVM: weatherVM)
                
                CityView(city: weatherVM.weatherApiResponse?.city ?? City(name: "- -", country: "-"), timeinterval: weatherVM.weatherApiResponse?.list.first?.dt)
        
                weatherVM.weatherApiResponse?.list.first.map({ weatherOfDay in
                    WeatherDescriptionView(today: weatherOfDay)
                })
                
                
                WeatherElementView(weatherAttribute: "Humidity", weatherAttributeVal: weatherVM.weatherApiResponse?.list.first?.humidity ?? 0)
                WeatherElementView(weatherAttribute: "Pressure", weatherAttributeVal: weatherVM.weatherApiResponse?.list.first?.pressure ?? 0)
                WeatherElementView(weatherAttribute: "Gusts", weatherAttributeVal: weatherVM.weatherApiResponse?.list.first?.gust ?? 0)
                Text("Next 5 Days")
                    .padding(.leading, 16)
                    .padding(.top, 16)
                    .padding(.bottom, -8)
                
                if let list = weatherVM.weatherApiResponse?.list {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [row], spacing: 0) {
                            ForEach(1..<list.count, id: \.self) { i in
                                NextDayView(weatherOfDay: list[i])
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherVM: WeatherViewModel())
    }
}
