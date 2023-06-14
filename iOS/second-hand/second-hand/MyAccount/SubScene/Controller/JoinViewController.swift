//
//  LoginViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/14.
//

import UIKit

class JoinViewController: NavigationUnderLineViewController {
    // TODO: 공사예정
    var circleButton = UIButton()
    let idStackView = UIStackView()
    let contour = UILabel()
    let addLocationButton = UIButton()
    let stackView = UIStackView()
    let plusLabel = UILabel()
    let addLocationText = UILabel()
    let idLabel = UILabel()
    let idTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCircleButton()
        setContour()
        setAddLocationButton()
        setStackView()
        setConstraints()
        setLabel()
        setTextField()
    }
    
    func setCircleButton() {
        circleButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // 크기 설정
        circleButton.layer.cornerRadius = circleButton.layer.frame.size.width/2
        circleButton.layer.masksToBounds = true
        circleButton.layer.borderWidth = 1
        circleButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        circleButton.setImage(UIImage(systemName: "camera"), for: .normal)
        circleButton.tintColor = .black
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "회원가입"
        setNavigationRightBarButton()
        setNavigationLeftBarButton()
    }
    
    func setContour() {
        contour.backgroundColor = UIColor.neutralBorder
    }
    
    private func setNavigationRightBarButton() {
        let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(save))
        
        let leftBarAttribute = [NSAttributedString.Key.font: UIFont.body,
                                NSAttributedString.Key.foregroundColor: UIColor.neutralTextWeak]
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
    
    func setAddLocationButton() {
        addLocationButton.frame = CGRect(x: 0, y: 0, width: 361, height: 52)
        addLocationButton.layer.borderWidth = 1
        addLocationButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        addLocationButton.setTitleColor(.black, for: .normal)
        addLocationButton.layer.cornerRadius = 8
        addLocationButton.layer.masksToBounds = true
    }
    
    func setAddLocationText() {
        
        addLocationText.text = "위치 추가"
        addLocationText.font = UIFont.subHead
        self.stackView.addArrangedSubview(addLocationText)
    }
    
    func setPlusLabel() {
        //일단 임의로 작성
        plusLabel.text = "+"
        plusLabel.font = UIFont.subHead
        plusLabel.textAlignment = .center
        self.stackView.addArrangedSubview(plusLabel)
    }
    
    func setStackView() {
        setPlusLabel()
        setAddLocationText()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    func setConstraints() {
        self.view.addSubview(idStackView)
        self.view.addSubview(circleButton)
        self.view.addSubview(contour)
        self.view.addSubview(addLocationButton)
        self.addLocationButton.addSubview(stackView)
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        idStackView.translatesAutoresizingMaskIntoConstraints = false
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        contour.translatesAutoresizingMaskIntoConstraints = false
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        addLocationText.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            
            circleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            circleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 130.0),
            circleButton.widthAnchor.constraint(equalToConstant: 80),
            circleButton.heightAnchor.constraint(equalToConstant: 80),
            
            idStackView.topAnchor.constraint(equalTo: self.circleButton.bottomAnchor,constant: 35.0),
            idStackView.heightAnchor.constraint(equalToConstant: 44),
            
            
            contour.topAnchor.constraint(equalTo: idStackView.bottomAnchor),
            contour.heightAnchor.constraint(equalToConstant: 0.5),
            contour.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            contour.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            addLocationButton.topAnchor.constraint(equalTo: contour.bottomAnchor, constant: 40),
            addLocationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            addLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            addLocationButton.heightAnchor.constraint(equalToConstant: 52),

            stackView.centerXAnchor.constraint(equalTo: self.addLocationButton.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.addLocationButton.centerYAnchor),
            
            idLabel.heightAnchor.constraint(equalToConstant: 22),
            idLabel.leadingAnchor.constraint(equalTo: idStackView.leadingAnchor, constant: 16),
            idLabel.centerYAnchor.constraint(equalTo: idStackView.centerYAnchor),
            
            idTextField.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 52.74),
            idTextField.centerYAnchor.constraint(equalTo: idStackView.centerYAnchor),
            idTextField.heightAnchor.constraint(equalToConstant: 22),
            
            

        ])
    }
    
    private func setLabel() {
        idLabel.text = "아이디"
        idLabel.font = UIFont.body
    }
    
    private func setTextField() {
        idTextField.placeholder = "아이디를 입력하세요"
        idTextField.font = UIFont.body
    }
    
    
    
}

extension JoinViewController: UITextFieldDelegate {
    
}
