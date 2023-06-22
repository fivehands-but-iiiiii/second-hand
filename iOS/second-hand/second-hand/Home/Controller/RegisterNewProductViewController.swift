//
//  RegisterNewProductViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/21.
//

import UIKit

final class RegisterNewProductViewController: NavigationUnderLineViewController {
    
    let sectionLine1 = UIView.makeLine()
    let sectionLine2 = UIView.makeLine()
    let sectionLine3 = UIView.makeLine()
    let square = UIButton.makeSquare(width: 80, height: 80, radius: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        layout()
    }
    
    private func setUI() {
        setNavigation()
        setSquare()
    }
    
    private func setNavigation() {
        navigationItem.title = "내 물건 팔기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .neutralText
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(finishButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .neutralTextWeak
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func finishButtonTapped() {
        print("저장")
    }
    
    func setSquare() {
        square.setTitle("0/10", for: .normal)
            square.setImage(UIImage(systemName: "camera"), for: .normal)
            
            square.contentHorizontalAlignment = .center
            square.contentVerticalAlignment = .bottom
    }
    
    private func layout() {
        var sectionArr = [sectionLine1, sectionLine2, sectionLine3, square]
        sectionArr.forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
           
            sectionLine1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 167),
            sectionLine1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
            sectionLine2.topAnchor.constraint(equalTo: sectionLine1.bottomAnchor, constant: 52),
            sectionLine2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            sectionLine3.topAnchor.constraint(equalTo: sectionLine2.bottomAnchor, constant: 52),
            sectionLine3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            square.bottomAnchor.constraint(equalTo: sectionLine1.topAnchor, constant: -15),
            square.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15)
        ])
    }
}

