//
//  DispatchQueue+Init.swift
//  WTHR
//
//  Created by Гена Книжник on 31.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension DispatchQueue {

    enum LabelType: String {
        
        case searchCityViewModel
        
    }
    
     convenience init(type: LabelType) {
        self.init(label: type.rawValue)
    }
    
}
