//
//  Utils.swift
//  second-hand
//
//  Created by SONG on 2023/07/11.
//

import UIKit

class Utils {
    
    static func safeAreaTopInset() -> CGFloat {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let window = windowScene.windows.first
                let statusBarManager = window?.windowScene?.statusBarManager
                guard let topPadding = statusBarManager?.statusBarFrame.height
                else {
                    return 0.0
                }
                return topPadding + 10.0
            }
        }
        return 0.0
    }
    
    static func screenWidth() -> CGFloat {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let window = windowScene.windows.first
                return window?.screen.bounds.width ?? 0.0
            }
        }
        return UIScreen.main.bounds.size.width
    }
}
