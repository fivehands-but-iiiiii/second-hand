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
        
    }
}
