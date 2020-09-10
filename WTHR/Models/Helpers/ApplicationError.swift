//
//  ApplicationError.swift
//  WTHR
//
//  Created by Гена Книжник on 27.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

enum ApplicationError: Error, LocalizedError {

    case urlError(URLError)
    case decodingError(DecodingError)
    case badRequest
    case notAuthorized
    case internetConnectionLost(Error?)
    case requestNotFound
    case serverError
    case unknownHttpErrorCode(Int)
    case unknownResponseError
    
    // MARK: - LocalizedError
    
    var errorDescription: String? {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
        case .decodingError(let error):
            return error.localizedDescription
        case .badRequest:
            return "Bad request"
        case .notAuthorized:
            return "Not Authorized"
        case .internetConnectionLost(let error):
            return error?.localizedDescription ?? "Internet Connection has been lost"
        case .requestNotFound:
            return "Request not found"
        case .serverError:
            return "Server error"
        case .unknownHttpErrorCode(let code):
            return "Unknown http error code: \(code)"
        case .unknownResponseError:
            return "Unknown response error"
        }
    }

}
