//
//  ItemDetailViewController.swift
//  second-hand
//
//  Created by SONG on 2023/07/09.
//

import UIKit

class ItemDetailViewController: UIViewController {
    private var backButton: UIButton? = nil
    private var menuButton: UIButton? = nil
    private let imagePages = ItemDetailImagePages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeScene()
    }
    
    private func initializeScene() {
        self.view.backgroundColor = .white
        setNavigationBatHidden()
        generateBackButton()
        generateMenuButton()
        setImagePages()
        setConstraintsBackButton()
        setConstraintsMenuButton()
    }
    // MARK: BUTTONS
    
    private func generateBackButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTouched), for: .touchUpInside)
        self.backButton = button
    }
    
    private func generateMenuButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action:#selector(menuButtonTouched), for: .touchUpInside)
        self.menuButton = button
        
    }
    
    private func setConstraintsBackButton() {
        guard let backButton = self.backButton else {
            return
        }
        
        self.view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    private func setConstraintsMenuButton() {
        guard let menubutton = self.menuButton else {
            return
        }
        
        self.view.addSubview(menubutton)
        
        menubutton.translatesAutoresizingMaskIntoConstraints = false
        
        menubutton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        menubutton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    private func setNavigationBatHidden() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc private func backButtonTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func menuButtonTouched() {
        
    }
    
    // MARK: IMAGE PAGES
    
    private func setImagePages() {
        setConstraintsImagePages()
    }
    
    private func setConstraintsImagePages() {
        self.view.addSubview(imagePages)
        
        imagePages.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                imagePages.topAnchor.constraint(equalTo: self.view.topAnchor),
                imagePages.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                imagePages.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
                imagePages.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
}
