//
//  CityView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct CityView: View {
    
    var city: City
    var timeinterval: TimeInterval?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(city.name)
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                Text(city.country)
                    .font(.system(size: 30))
                    .fontWeight(.medium)
                if let timeinterval = timeinterval {
                    Text(getToday(for: timeinterval))
                        .font(.system(size: 20))
                }

            }
            
            Spacer()
        }
        .padding([.leading, .trailing])
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(city: City(name: "New Delhi", country: "IN"), timeinterval: 1685255400).previewLayout(.fixed(width: 372, height: 180))
    }
}
