//
//  AppLifeCycleServiceProtocol.swift
//  WTHR
//
//  Created by Гена Книжник on 26.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine

protocol AppLifeCycleServiceProtocol {
    
    var appInBackgroundSubject: PassthroughSubject<Bool, Never> { get }
    
}
