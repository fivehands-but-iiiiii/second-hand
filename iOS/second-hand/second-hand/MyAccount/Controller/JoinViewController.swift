//
//  LoginViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/13.
//

import UIKit

class JoinViewController: NavigationUnderLineViewController {
    var circleButton = UIButton()
    let idLabel = UILabel()
    let idTextField = UITextField()
    let contour = UILabel()
    let addLocationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.navigationItem.title = "내 계정"
        setNavigationRightBarButton()
        setNavigationLeftBarButton()
        setCircleButton()
        layout()
        setIdLabel()
        setIdTextField()
        setContour()
        setAddLocationButton()
    }
    
    private func setNavigationRightBarButton() {
        let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(save))
        
        let leftBarAttribute = [NSAttributedString.Key.font: UIFont.body,
                                NSAttributedString.Key.foregroundColor: UIColor.neutralText]
        saveButton.setTitleTextAttributes(leftBarAttribute, for: .normal)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func save() {
        print("저장됨 !")
    }
    
    private func setNavigationLeftBarButton() {
        let backButton = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismisss))
        
        let leftBarAttribute = [NSAttributedString.Key.font: UIFont.body,
                                NSAttributedString.Key.foregroundColor: UIColor.neutralText]
        backButton.setTitleTextAttributes(leftBarAttribute, for: .normal)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func dismisss() {
        self.dismiss(animated: true)
    }
    
    func setCircleButton() {
        circleButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // 크기 설정
        circleButton.layer.cornerRadius = circleButton.layer.frame.size.width/2
        circleButton.layer.masksToBounds = true
        circleButton.layer.borderWidth = 1
        circleButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        circleButton.setImage(UIImage(systemName: "camera"), for: .normal)
    }
    
    func setIdLabel() {
        idLabel.text = "아이디"
        idLabel.font = UIFont(name: "SFPro-Regular", size: 17)
        
    }
    
    func setIdTextField() {
        idTextField.placeholder = "아이디를 입력하세요"
    }
    
    func setContour() {
        contour.backgroundColor = UIColor.neutralBorder
    }
    
    func setAddLocationButton() {
        addLocationButton.setTitle("위치 추가", for: .normal)
        addLocationButton.titleLabel?.font = UIFont(name: "SFPro-Regular", size: 15)
        addLocationButton.layer.borderWidth = 1
        addLocationButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        addLocationButton.setTitleColor(.black, for: .normal)
    }
    func layout() {
        self.view.addSubview(circleButton)
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        self.view.addSubview(contour)
        self.view.addSubview(addLocationButton)
        
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        contour.translatesAutoresizingMaskIntoConstraints = false
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            circleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 161.5),
            circleButton.widthAnchor.constraint(equalToConstant: 80),
            circleButton.heightAnchor.constraint(equalToConstant: 80),
            
            idLabel.topAnchor.constraint(equalTo: self.circleButton.bottomAnchor, constant: 35),
            idLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            idTextField.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 52.74),
            idTextField.topAnchor.constraint(equalTo: idLabel.topAnchor),
            
            contour.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10.5),
            contour.heightAnchor.constraint(equalToConstant: 0.5),
            contour.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            
            addLocationButton.topAnchor.constraint(equalTo: contour.bottomAnchor, constant: 40),
            addLocationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            addLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            addLocationButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
