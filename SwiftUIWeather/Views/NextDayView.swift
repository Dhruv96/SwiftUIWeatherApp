//
//  NextDayView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct NextDayView: View {
    let weatherOfDay: WeatherOfDay
    var body: some View {
        VStack {
            Text(getDay(from: weatherOfDay.dt))
                .padding(.top, 8)
            let urlString = "https://openweathermap.org/img/wn/\(weatherOfDay.weather.first!.icon)@2x.png"
                AsyncImage(url: URL(string: urlString)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: 80, height: 80)
                }
            if let temp = weatherOfDay.temp.day {
                Text(String(temp) + " °C")
                    .padding(.bottom, 8)
            }
            
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.3))
        }
        .padding(.leading, 8)
    }
}

struct NextDayView_Previews: PreviewProvider {
    static var previews: some View {
        NextDayView(weatherOfDay: WeatherOfDay(temp: Temp(day: 0, night: 0, eve: 0), pressure: 0, humidity: 0, feels_like: Temp(day: 0, night: 0, eve: 0), weather: [Description(id: 1, main: "Clear", description: "Sunny", icon: "10d")], gust: 0, dt: 0))
            .previewLayout(.sizeThatFits)
    }
}
