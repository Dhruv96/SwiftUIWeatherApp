//
//  Helpers.swift
//  SwiftUIWeather
//
//  Created by Dhruv Grover on 26/05/23.
//

import Foundation

func getDay(from timeinterval: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timeinterval)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .gmt
    dateFormatter.dateFormat = "EEE"
    return dateFormatter.string(from: date)
}

func getToday(for timeinterval: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timeinterval)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .gmt
    dateFormatter.dateFormat = "EEE, dd MMM"
    return dateFormatter.string(from: date)
}
