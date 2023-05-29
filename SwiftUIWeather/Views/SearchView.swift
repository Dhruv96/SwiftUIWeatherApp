//
//  SearchView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        HStack {
            Button {
                // get user's location
            } label: {
                Image(systemName: "location.circle").resizable().frame(width: 30, height: 30)
                    .tint(.white)
            }
            
            
            TextField("Enter city..", text: $searchText)
                .frame(height: 40)
                .padding(.leading, 8)
                .background(content: {
                    Color.black.opacity(0.5)
                })
                .cornerRadius(8)
                .padding(8)
            
            Button {
                // fetch location data
                weatherVM.fetchWeatherDetails(for: searchText)
                
            } label: {
                Image(systemName: "magnifyingglass").resizable().frame(width: 30, height: 30)
                    .tint(.white)
            }
        }
        .padding([.leading, .trailing])
        .padding(.top, 48)
        .onAppear() {
            weatherVM.fetchWeatherDetails(for: "New Delhi")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant(""), weatherVM: WeatherViewModel()).previewLayout(.sizeThatFits)
    }
}
