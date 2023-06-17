//
//  HTTPError.swift
//  second-hand
//
//  Created by SONG on 2023/06/15.
//

import Foundation

enum ManagerErrors: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}

extension ManagerErrors {
    @frozen
    enum statuscode: Int {
        case internalServerError = 500
        case notFound = 404
    }
}
