//
//  SaleLogViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class SaleLogViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "판매 내역"
        setNavigationBarFrame()
        setNavigationBarBottomBorder()
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
}

