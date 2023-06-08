//
//  ButtonCustomView.swift
//  second-hand
//
//  Created by SONG on 2023/06/07.
//

import UIKit

class ButtonCustomView: UIButton {
    private var label = UILabel(frame: .zero)
    private var sideImage = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
        setSideImage()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setLabel() {
        
        label.text = "역삼1동"
        label.font = UIFont.headLine
        label.textColor = .black
        self.addSubview(label)
    }
    
    private func setSideImage() {
        sideImage = UIImageView(image: UIImage(systemName: "chevron.down"))
        sideImage.tintColor = .black
        sideImage.contentMode = .scaleAspectFit
        self.addSubview(sideImage)
    }
    private func setContraints(){
        label.translatesAutoresizingMaskIntoConstraints = false
        sideImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            sideImage.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 4),
            sideImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sideImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
}
