//
//  Extension+UIColor.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/07.
//

import UIKit

extension UIColor {
    enum colorSet {
        case white, gray50, gray100, gray200, gray300, gray400, gray500, gray600, gray700, gray800, gray900, black, mint, orange, blue, red

        var color: UIColor {
            switch self {
            case .white:
                return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            case .gray50:
                return UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
            case .gray100:
                return UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.8)
            case .gray200:
                return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.7)
            case .gray300:
                return UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.12)
            case .gray400:
                return UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
            case .gray500:
                return UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.39)
            case .gray600:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            case .gray700:
                return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
            case .gray800:
                return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
            case .gray900:
                return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 1)
            case .black:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            case .mint:
                return UIColor(red: 0/255, green: 199/255, blue: 190/255, alpha: 1)
            case .orange:
                return UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
            case .blue:
                return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
            case .red:
                return UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
            }
        }
    }
    static let neutralText = UIColor.colorSet.gray900
    static let neutralTextWeak = UIColor.colorSet.gray800
    static let neutralTextStrong = UIColor.colorSet.black
    static let neutralBackground = UIColor.colorSet.white
    static let neutralBackgroundWeak = UIColor.colorSet.gray50
    static let neutralBackgroundBold = UIColor.colorSet.gray400
    static let BackgroundBulr = UIColor.colorSet.gray100
    static let neutralBorder = UIColor.colorSet.gray500
    static let neutralBorderStrong = UIColor.colorSet.gray700
    static let neutralOveray = UIColor.colorSet.gray600
    static let accentText = UIColor.colorSet.white
    static let accentTextWeak = UIColor.colorSet.black
    static let accentBackgroundPrimary = UIColor.colorSet.orange
    static let accentBackgroundSecondary = UIColor.colorSet.mint
    static let systemDefault = UIColor.colorSet.blue
    static let systemWarning = UIColor.colorSet.red
    static let systemBackground = UIColor.colorSet.white
    static let systemBackgroundWeak = UIColor.colorSet.gray200
}
