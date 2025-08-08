//
//  WeatherDescriptionView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct WeatherDescriptionView: View {
    @ObservedObject var weatherForecastVM : WeatherForecastViewModel
    // https://openweathermap.org/img/wn/10d@2x.png
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: weatherForecastVM.urlString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: 150, height: 150)
            }
        
            
            Spacer()
            
            VStack {
                Text(String(weatherForecastVM.temp) + " °C")
                    .font(.system(size: 40, weight: .medium, design: .default))
                    .fontWeight(.medium)
                Text(weatherForecastVM.description)
                    .font(.system(size: 25, weight: .regular, design: .rounded))
                    .fontWeight(.regular)
            }
        }
        .padding()
    }
}

struct WeatherDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDescriptionView(weatherForecastVM: WeatherForecastViewModel(urlString: "", temp: 23.3, description: ""))
    }
}
