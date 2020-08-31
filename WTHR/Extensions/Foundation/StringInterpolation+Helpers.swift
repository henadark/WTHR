//
//  StringInterpolation+Helpers.swift
//  WTHR
//
//  Created by Гена Книжник on 30.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension String.StringInterpolation {
    
    mutating func appendInterpolation(temperature date: Date) {
        let components = date.get(.day, .month)
        if let day = components.day, let month = components.month {
            let result = day.description + "\n" + DateFormatter().monthSymbols[month - 1].prefix(.maxMonthNameLength)
            appendLiteral(result)
        }
    }
    
    mutating func appendInterpolation(monthAndDayFrom date: Date) {
        let components = date.get(.day, .month)
        if let day = components.day, let month = components.month {
            let result = "\(DateFormatter().monthSymbols[month - 1]), \(day)"
            appendLiteral(result)
        }
    }
    
    mutating func appendInterpolation(temperature: Double) {
        let result = "\(temperature.int)°"
            appendLiteral(result)
        
    }
    
}
