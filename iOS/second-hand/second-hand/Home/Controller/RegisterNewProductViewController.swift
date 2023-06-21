//
//  RegisterNewProductViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/21.
//

import UIKit

final class RegisterNewProductViewController: NavigationUnderLineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        setNavigation()
        
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
}
