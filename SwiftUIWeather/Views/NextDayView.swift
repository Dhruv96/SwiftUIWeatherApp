//
//  NextDayView.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 16/05/23.
//

import SwiftUI

struct NextDayView: View {
    @ObservedObject var nextDayVM: NextDayViewModel
    
    var body: some View {
        VStack {
            Text(getDay(from: nextDayVM.timeInterval))
                .padding(.top, 8)
            AsyncImage(url: URL(string: nextDayVM.urlString)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: 80, height: 80)
                }
            
            Text(String(nextDayVM.temp) + " °C")
                    .padding(.bottom, 8)
            
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
        NextDayView(nextDayVM: NextDayViewModel(urlString: "", temp: 23.4, timeInterval: TimeInterval()))
    }
}
