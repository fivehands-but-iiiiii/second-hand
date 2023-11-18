//
//  HTTPError.swift
//  second-hand
//
//  Created by SONG on 2023/06/15.
//

import Foundation

enum ErrorManager: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}

extension ErrorManager {
    enum statuscode: Int {
        case internalServerError = 500
        case idFormatError = 400
        case invalidToken = 403
        case notFound = 404
        case idConflictError = 409
    }
}
