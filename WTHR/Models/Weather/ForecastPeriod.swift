//
//  ForecastPeriod.swift
//  WTHR
//
//  Created by Гена Книжник on 30.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

enum ForecastPeriod: Int, CaseIterable {
    
    case min = 5
    case medium = 10
    case max = 15
    
    // MARK: Init
    
    init(with index: Int) {
        let allCases = Self.allCases
        if let period = allCases[safe: index] {
            self = period
        } else {
            self = .min
        }
    }
    
}

// MARK: Identifiable

extension ForecastPeriod: Identifiable {
    
    var id: Int { rawValue }
    
}

// MARK: Helpers

extension ForecastPeriod {
    
    var title: String { "\(rawValue) days" }
    
}
