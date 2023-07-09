//
//  ItemDetailViewController.swift
//  second-hand
//
//  Created by SONG on 2023/07/09.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialScene()
    }
    
    private func setInitialScene() {
        self.view.backgroundColor = .white
        setBarButton()
    }
    
    private func setBarButton() {
        let backButton = UIBarButtonItem(image:UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTouched))
        backButton.tintColor = .gray
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    @objc private func backButtonTouched() {
        navigationController?.popViewController(animated: true)
    }
}
