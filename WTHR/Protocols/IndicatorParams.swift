//
//  IndicatorParams.swift
//  WTHR
//
//  Created by Гена Книжник on 30.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

protocol IndicatorParams {
    
    var pressureIndidcator: IndicatorType { get }
    var humidityIndidcator: IndicatorType { get }
    var cloudinessIndidcator: IndicatorType { get }
    
}

extension IndicatorParams {
    
    var indicatorTypes: [IndicatorType] {
        [pressureIndidcator, humidityIndidcator, cloudinessIndidcator]
    }
    
}
