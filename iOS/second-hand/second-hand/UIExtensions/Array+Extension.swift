//
//  Array+Extension.swift
//  second-hand
//
//  Created by leehwajin on 2023/08/07.
//
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
