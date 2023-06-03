//
//  SearchView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    @Binding var isSearchResultsShowing: Bool
    @ObservedObject var weatherVM: WeatherViewModel
    @EnvironmentObject var searchModel: SearchModel
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                // get user's location
            } label: {
                Image(systemName: "location.circle").resizable().frame(width: 35, height: 35)
                    .tint(.white)
            }
            
            TextField("Enter city..", text: $searchText)
                .frame(height: 40)
                .padding(.leading, 8)
                .background(content: {
                    Color.black.opacity(0.5)
                })
                .cornerRadius(8)
                .padding(.horizontal, 8)
                .onTapGesture {
                    isSearchResultsShowing = true
                }
                .onChange(of: searchText) { newValue in
                    isSearchResultsShowing = true
                    if searchText != "" {
                        SearchModel.completer.queryFragment = searchText
                    }
                    else {
                        isSearchResultsShowing = false
                    }
                }
    
            Button {
                // fetch location data
                isSearchResultsShowing.toggle()
                weatherVM.fetchWeatherDetails(for: searchText)
                
            } label: {
                Image(systemName: "magnifyingglass").resizable().frame(width: 35, height: 35)
                    .tint(.white)
            }
        }
        .padding()
        .onAppear() {
            weatherVM.fetchWeatherDetails(for: "New Delhi")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant(""), isSearchResultsShowing: .constant(false), weatherVM: WeatherViewModel()).previewLayout(.sizeThatFits)
            .background(Color.blue)
    }
}
