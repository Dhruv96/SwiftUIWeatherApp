//
//  WeatherDescriptionView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct WeatherDescriptionView: View {
    var today: WeatherOfDay
    
    // https://openweathermap.org/img/wn/10d@2x.png
    var body: some View {
        HStack {
            if let urlString = "https://openweathermap.org/img/wn/\(today.weather.first!.icon)@2x.png" {
                AsyncImage(url: URL(string: urlString)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: 150, height: 150)
                }
            }
            
            Spacer()
            
            VStack {
                Text(String(today.temp.day) + " °C")
                    .font(.system(size: 40, weight: .medium, design: .default))
                    .fontWeight(.medium)
                Text(today.weather.first?.description ?? "")
                    .font(.system(size: 25, weight: .regular, design: .rounded))
                    .fontWeight(.regular)
            }
        }
        .padding()
    }
}

struct WeatherDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDescriptionView(today: WeatherOfDay(temp: Temp(day: 0, night: 0, eve: 0), pressure: 0, humidity: 0, feels_like: Temp(day: 0, night: 0, eve: 0), weather: [Description(id: 1, main: "Clear", description: "Sunny", icon: "10d")], gust: 0, dt: 0))
            .previewLayout(.sizeThatFits)
    }
}
