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
    var idDescription = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        idTextField.delegate = self
        idTextField.autocapitalizationType = .none
    }
    
    func setUI() {
        setNavigationBar()
        setCircleButton()
        setContour()
        setAddLocationButton()
        setStackView()
        setConstraints()
        setLabel()
        setTextField()
        setIdDescription()
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
    
    private func setLabel() {
        idLabel.text = "아이디"
        idLabel.font = UIFont.body
    }
    
    private func setTextField() {
        idTextField.placeholder = "아이디를 입력하세요"
        idTextField.font = UIFont.body
    }
    
    func setIdDescription() {
        idDescription.font = UIFont.caption2
        idDescription.textColor = UIColor.orange
    }
    
    
    func setConstraints() {
        let addSubviewComponent = [idStackView, circleButton, contour, addLocationButton, idLabel, idTextField, idDescription]
        addSubviewComponent.forEach{self.view.addSubview($0)}
        self.addLocationButton.addSubview(stackView)
        
        let component = [circleButton, idStackView, contour, addLocationButton, plusLabel, addLocationText, idLabel, idTextField, idDescription, stackView, idTextField, idLabel]
        component.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
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
            
            idDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            idDescription.topAnchor.constraint(equalTo: contour.bottomAnchor, constant: 3),
            
        ])
    }
    
    
    
    
    
}

extension JoinViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //6글자 미만일 경우 디스크립션 텍스트 변경
        if (textField.text?.count)! + string.count < 6 {
            idDescription.text = "6~12자 이내로 입력하세요"
        }else{
            idDescription.text = ""
        }
       
        if string.isEmpty {
            //백스페이스 버튼이 눌린다면 무조건 허용
            return true
        }
        //12자이상시 false
        guard (textField.text?.count)! + string.count <= 12 else {return false}
        //숫자영어뺴곤 false
        let textVerification = isEnglishNumber(string)
        guard textVerification else {return false}
        
        //중복된 아이디라면 디스크립션 텍스트 변경
        let testIdArray = ["hahahaha", "hohohoho"]
        if testIdArray.contains(textField.text! + string ) {
            idDescription.text = "이미 사용중인 아이디예요"
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //화면 터치시 키보드 내려감
        idTextField.resignFirstResponder()

    }
    
    func isEnglishNumber(_ string: String) -> Bool{
        let englishNumber = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz1234567890")
        return englishNumber.contains(UnicodeScalar(String(string))!)
    }
  
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
