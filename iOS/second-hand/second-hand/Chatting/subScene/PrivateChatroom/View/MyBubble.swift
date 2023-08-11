//
//  MyBubble.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class MyBubble: Bubble {
    private let bubbleImage = UIImage(systemName: "bubble.right.fill")?.resizableImage(withCapInsets: UIEdgeInsets(top: 4, left: 10.0, bottom: 6, right: 6.0), resizingMode: .stretch)
    
    override init(text: String) {
        super.init(text: text)
        self.image = bubbleImage
        self.tintColor = .accentBackgroundPrimary
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
