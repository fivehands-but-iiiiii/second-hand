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
    
    private func setInitialStatus(status : Int){
        switch status{
        case 0:
            self.status = "판매중"
        case 1:
            self.status = "예약중"
        case 2:
            self.status = "판매완료"
        default:
            self.status = "unknown"
        }
    }
    
    private func setLabel() {
        label.text = self.status
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.textColor = .black
        self.addSubview(label)
    }
    
    private func setSideImage() {
        sideImage = UIImageView(image: UIImage(systemName: "chevron.down"))
        sideImage.tintColor = .black
        sideImage.contentMode = .scaleAspectFit
        self.addSubview(sideImage)
    }
    
    private func setBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        let cornerRadius = min(bounds.width, bounds.height) / 3
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
}
