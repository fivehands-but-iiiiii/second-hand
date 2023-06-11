//
//  SaleLogNaviView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/09.
//

import UIKit

class SaleLogNavigationView: UIView {
    // TODO: 메소드 쪼개고 하드코딩 지양 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        let titleLabel = UILabel()
        titleLabel.text = "판매내역"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        let segmentControl = UISegmentedControl(items: ["판매중", "판매완료"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        
        self.addSubview(titleLabel)
        self.addSubview(segmentControl)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            segmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            segmentControl.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            segmentControl.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        
        let selectedIndex = sender.selectedSegmentIndex
        // 선택된 인덱스에 따라 원하는 동작 수행
    }
}
