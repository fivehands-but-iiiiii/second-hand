//
//  UIFont+Extension.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/07.
//

import UIKit
extension UIFont {
    enum FontType: String {
        case semibold = "semibold"
        case regular = "regular"
    }
    
    static let largeTitle = UIFont(name: FontType.regular.rawValue, size: 34)
    static let title1 = UIFont(name: FontType.regular.rawValue, size: 28)
    static let title2 = UIFont(name: FontType.regular.rawValue, size: 22)
    static let title3 = UIFont(name: FontType.regular.rawValue, size: 20)
    static let headLine = UIFont(name: FontType.semibold.rawValue, size: 17)
    static let body = UIFont(name: FontType.regular.rawValue, size: 17)
    static let callOut = UIFont(name: FontType.regular.rawValue, size: 16)
    static let subHead = UIFont(name: FontType.regular.rawValue, size: 15)
    static let footNote = UIFont(name: FontType.regular.rawValue, size: 13)
    static let caption1 = UIFont(name: FontType.regular.rawValue, size: 12)
    static let caption2 = UIFont(name: FontType.regular.rawValue, size: 11)
}

