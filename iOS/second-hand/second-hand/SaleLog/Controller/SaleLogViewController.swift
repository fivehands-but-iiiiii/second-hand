//
//  SaleLogViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class SaleLogViewController: UIViewController {
    let titleLabel = UILabel()
    let segmentControl = UISegmentedControl(items: ["판매중", "판매완료"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "판매 내역"
        setNavigationBarFrame()
        setNavigationBarBottomBorder()
        setUI()
        layout()
    }
    
    func setUI() {
        setTitleLabel()
        setSegmentControl()
        
       
    }
    
    func setTitleLabel() {
        titleLabel.text = "판매내역"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    func setSegmentControl() {
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }
    
    private func setNavigationBarFrame() {
        navigationController?.navigationBar.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 100))
    }
    
    func setNavigationBarBottomBorder() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        let borderView = UIView(frame: CGRect(x: .zero, y: navigationBar.frame.maxY, width: navigationBar.frame.width, height: 1))
        
        borderView.backgroundColor = .lightGray
        navigationBar.addSubview(borderView)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        
        let selectedIndex = sender.selectedSegmentIndex
        // 선택된 인덱스에 따라 원하는 동작 수행
    }
    
    func layout() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(segmentControl)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            segmentControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 102),
            segmentControl.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            segmentControl.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
}

