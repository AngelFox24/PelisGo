//
//  DateExtension.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation

enum DateComponent {
    case day
    case month
    case year
    var numberString: String {
        switch self {
        case .day:
            return "dd"
        case .month:
            return "MM"
        case .year:
            return "YYYY"
        }
    }
}

extension Date {
    func getDateComponent(dateComponent: DateComponent) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateComponent.numberString

        return Int(dateFormatter.string(from: self)) ?? 0
    }
    func getDateFormat(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self)
    }
}
