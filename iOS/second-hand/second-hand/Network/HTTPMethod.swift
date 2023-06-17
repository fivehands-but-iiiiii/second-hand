//
//  HTTPMethod.swift
//  second-hand
//
//  Created by SONG on 2023/06/15.
//

import Foundation

enum HttpMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    
    var method: String { rawValue.uppercased() }
}
