//
//  ChattingViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class ChattingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = "채팅"
        setNavigationBarBottomBorder()
    }
    
    func setNavigationBarBottomBorder() {
            let borderView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: navigationController?.navigationBar.frame.width ?? 0, height: 1))
            borderView.backgroundColor = .lightGray
            navigationController?.navigationBar.addSubview(borderView)
        }
}
