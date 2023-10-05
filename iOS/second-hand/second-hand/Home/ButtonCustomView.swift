//
//  ButtonCustomView.swift
//  second-hand
//
//  Created by SONG on 2023/06/07.
//

import UIKit

final class ButtonCustomView: UIButton {
    
    var label = UILabel(frame: .zero)
    private var sideImage = UIImageView(frame: .zero)
    var delegate : ButtonActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
        setSideImage()
        setContraints()
        setMenu()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLabel(text: String) {
        self.label.text = text
    }
    private func setLabel() {
        
        label.text = ""
        label.font = UIFont.headLine
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
    private func setContraints(){
        label.translatesAutoresizingMaskIntoConstraints = false
        sideImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            sideImage.leadingAnchor.constraint(equalTo: label.trailingAnchor,constant: 5.0),
            sideImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sideImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setMenu() {
        let children : [UIAction] =
        [
            UIAction(title: "동네를 설정하세요", handler: { [weak self] _ in self?.delegate?.setRegionButtonTouched?()
            })
        ]
        self.menu = UIMenu(options: .displayInline,children: children)
        self.showsMenuAsPrimaryAction = true
    }
}
