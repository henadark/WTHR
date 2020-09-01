//
//  Serializable.swift
//  WTHR
//
//  Created by Гена Книжник on 12.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

protocol Serializable {
    
    func toJSON() -> Parameters
    
}

extension Serializable {
    
    var queryItems: [URLQueryItem] { toJSON().map { URLQueryItem(name: $0.key, value: $0.value) } }
    
}
