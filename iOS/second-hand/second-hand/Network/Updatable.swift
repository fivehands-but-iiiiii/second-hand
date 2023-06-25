//
//  Updatable.swift
//  second-hand
//
//  Created by SONG on 2023/06/25.
//

import Foundation

protocol Updatable {
    func updateData<T:Codable> (from fetchedData: T)
}
