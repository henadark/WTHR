//
//  NSManagedObjectContext+Performs.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

private enum HandlerPerfofrm<T> {
    case nothing
    case value(T)
    case error(Error)
}

extension NSManagedObjectContext {
    
    func performAndWaitWithException<T>(_ completionBlock: () throws -> T) throws -> T {
        var value: HandlerPerfofrm<T> = .nothing
        performAndWait {
            do {
                value = .value(try completionBlock())
            } catch let exceptionError {
                value = .error(exceptionError)
            }
        }
        return try handlePerform(value)
    }
    
    private func handlePerform<T>(_ value: HandlerPerfofrm<T>) throws -> T {
        switch value {
        case .nothing:
            fatalError("performAndWaitWithException completion block hasn't been called")
        case let .error(error):
            throw error
        case let .value(value):
            return value
        }
    }
    
}
