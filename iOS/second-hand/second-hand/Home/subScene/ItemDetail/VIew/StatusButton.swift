//
//  StatusButton.swift
//  second-hand
//
//  Created by SONG on 2023/07/16.
//

import UIKit

protocol StatusButtonChange {
    func onsale()
    func reservation()
    func soldOut()
}

class StatusButton: UIButton {
    private var status : String? = nil
    private var label = UILabel(frame: .zero)
    private var sideImage = UIImageView(frame: .zero)
    var isMine: Bool? = nil
    var delegate: StatusButtonChange?
    
    init(status: Int,isMine: Bool) {
        super.init(frame: .zero)
        setInitialStatus(status: status)
        self.isMine = isMine
        setLabel()
        setSideImage()
        setMenu()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setContraints()
        setBorder()
    }
    
    
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
    
    private func setMenu() {
        
        let children : [UIAction] =
        [
            UIAction(title: "판매중", handler: { [weak self] _ in
                self?.label.text = "판매중"
                self?.delegate?.onsale()
            }),
            UIAction(title: "예약중", handler: { [weak self] _ in
                self?.label.text = "예약중"
                self?.delegate?.reservation()
            }),
            UIAction(title: "판매완료", handler: { [weak self] _ in
                self?.label.text = "판매완료"
                self?.delegate?.soldOut()
            })
        ]
        
        self.menu = UIMenu(options: .displayInline,children: children)

        self.showsMenuAsPrimaryAction = true
    }
    
    private func setContraints(){
        label.translatesAutoresizingMaskIntoConstraints = false
        sideImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 15),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            sideImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15),
            sideImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
