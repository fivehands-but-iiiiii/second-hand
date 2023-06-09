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
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        setNavigationBarBottomBorder()
        setupNavigationBarHeight()
    }
    
    func setNavigationBarBottomBorder() {
        let borderView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 , width: navigationController?.navigationBar.frame.width ?? 0, height: 1))
        borderView.backgroundColor = .lightGray
        navigationController?.navigationBar.addSubview(borderView)
    }
    
    func setupNavigationBarHeight() {
        if let navigationController = self.navigationController {
            let navigationBarHeight: CGFloat = 100
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let newNavigationBarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarHeight + statusBarHeight)
            navigationController.navigationBar.frame = newNavigationBarFrame
            
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.isTranslucent = true
            
            let titleView = SaleLogNavigationView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
            navigationController.navigationBar.topItem?.titleView = titleView
            
        }
    }
    
    func setUI() {
        
    }
}

