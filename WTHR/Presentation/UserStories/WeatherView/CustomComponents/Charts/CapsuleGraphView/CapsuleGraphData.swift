//
//  CapsuleGraphData.swift
//  WTHR
//
//  Created by Гена Книжник on 28.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct CapsuleGraphData {
    
    let value, min, max: Double
    let title: String
    
}

// MARK: - Helpers

extension CapsuleGraphData {
    
    var valueDescription: String { value.int.description }
    
    var range: Int { (min.int...max.int).count }
    
}

// MARK: - Identifiable

extension CapsuleGraphData: Identifiable {
    
    var id: String { title }
    
}

// MARK: - Factory

struct CapsuleGraphDataFactory {
    
    static func defaultGraphData(min: Double, max: Double) -> CapsuleGraphData {
        return CapsuleGraphData(value: min,
                                min: min,
                                max: max,
                                title: "\(temperature: Date())")
    }
    
}
