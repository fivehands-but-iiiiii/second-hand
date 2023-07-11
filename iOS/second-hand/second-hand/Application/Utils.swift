//
//  Utils.swift
//  second-hand
//
//  Created by SONG on 2023/07/11.
//

import UIKit

class Utils {
    public static let STATUS_HEIGHT = UIApplication.shared.statusBarFrame.size.height   // 상태바 높이

    static func safeAreaTopInset() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            return topPadding ?? Utils.STATUS_HEIGHT
        } else {
            return Utils.STATUS_HEIGHT
        }
    }
}
