//
//  CityView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct CityView: View {
    
    @ObservedObject var cityVM: CityViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(cityVM.name)
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                Text(cityVM.country)
                    .font(.system(size: 30))
                    .fontWeight(.medium)
                if let timeInterval = cityVM.timeInterval{
                    Text(getToday(for: timeInterval))
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
        CityView(cityVM: CityViewModel(name: "Delhi", country: "India", timeInterval: TimeInterval()))
    }
}
