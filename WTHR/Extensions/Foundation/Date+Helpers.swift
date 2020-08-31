//
//  Date+Helpers.swift
//  WTHR
//
//  Created by Гена Книжник on 29.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension Date {
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
}
