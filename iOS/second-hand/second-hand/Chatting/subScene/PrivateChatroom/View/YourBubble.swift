//
//  YourBubble.swift
//  second-hand
//
//  Created by SONG on 2023/08/03.
//

import UIKit

class YourBubble: Bubble {
    private let bubbleImage = UIImage(systemName: "bubble.left.fill")?.resizableImage(withCapInsets: UIEdgeInsets(top: 4, left: 10.0, bottom: 6, right: 6.0), resizingMode: .stretch)
    
    override init(text: String) {
        super.init(text: text)
        self.image = bubbleImage
        self.tintColor = .accentBackgroundSecondary
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
