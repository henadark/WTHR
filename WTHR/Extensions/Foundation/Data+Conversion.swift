//
//  Data+Conversion.swift
//  WTHR
//
//  Created by Гена Книжник on 20.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension Data {
    
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
}
