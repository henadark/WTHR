//
//  Response.swift
//  WTHR
//
//  Created by Гена Книжник on 23.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

class ArrayResponse<T: Codable>: Codable {
    
    var results: [T]?
    
    // MARK: - Codable Protocol
    
    private enum CodingKeys: String, CodingKey {
        case results = "list"
    }
    
}
