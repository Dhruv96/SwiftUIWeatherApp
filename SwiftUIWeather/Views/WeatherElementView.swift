//
//  WeatherElementView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct WeatherElementView: View {
    let weatherAttribute: String
    let weatherAttributeVal: Double
    var icon: String {
        if weatherAttribute == "Humidity" {
            return "humidity"
        }
        else if weatherAttribute == "Pressure" {
            return "barometer"
        }
        else {
           return "wind"
        }
    }
   
    var body: some View {
        HStack {
            HStack{
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                
                Text(weatherAttribute)
            }
            
            Spacer()
            
            Text(String(weatherAttributeVal))
        }
        .padding()
        .background {
            Capsule(style: .circular)
                .fill(Color.black.opacity(0.3))
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct WeatherElementView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherElementView(weatherAttribute: "Humidity", weatherAttributeVal: 80)
            .previewLayout(.fixed(width: 372, height: 80))
    }
}
