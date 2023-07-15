//
//  StatusButton.swift
//  second-hand
//
//  Created by SONG on 2023/07/16.
//

import UIKit

class StatusButton: UIButton {
    private var status : String? = nil
    private var label = UILabel(frame: .zero)
    private var sideImage = UIImageView(frame: .zero)
    
    
    private func setLabel() {
        label.text = self.status
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.textColor = .black
        self.addSubview(label)
    }
    
}
