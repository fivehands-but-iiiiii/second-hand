//
//  LoginViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/14.
//

import UIKit

final class JoinViewController: NavigationUnderLineViewController {
    private let setLocationViewController = SetLocationViewController()
    private let circleButton = UIButton()
    private let idStackView = UIStackView()
    private let contour = UILabel()
    private let addLocationButton = UIButton()
    private let stackView = UIStackView()
    private let plusLabel = UILabel()
    private let addLocationText = UILabel()
    private let idLabel = UILabel()
    private let idTextField = UITextField()
    private var idDescription = UILabel()
    private let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        idTextField.delegate = self
        idTextField.autocapitalizationType = .none
    }
    
    private func setUI() {
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
    
    private func setCircleButton() {
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
    
    private func setContour() {
        contour.backgroundColor = UIColor.neutralBorder
    }
    
    private func setNavigationRightBarButton() {
        let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(save))
        
        let leftBarAttribute = [NSAttributedString.Key.font: UIFont.body,
                                NSAttributedString.Key.foregroundColor: UIColor.neutralTextWeak]
        saveButton.setTitleTextAttributes(leftBarAttribute, for: .normal)
        navigationItem.rightBarButtonItem = saveButton
        alert.addAction(UIAlertAction(title: "확인", style: .default))
    }
    
    @objc private func save() {
        if idDescription.text == "" {
            alert.message = "회원가입이 완료되었습니다."
            self.present(alert, animated: true, completion: {
                //TODO: 얼럿이 없어지기보단 모달형식의 JoinVC가 dismiss되야함
                self.dismiss(animated: true)
            })
        }else {
            alert.message = "아이디가 적절하지 않습니다."
            self.present(alert, animated: true, completion: nil)
        }
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
    
    private func setAddLocationButton() {
        addLocationButton.frame = CGRect(x: 0, y: 0, width: 361, height: 52)
        addLocationButton.layer.borderWidth = 1
        addLocationButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        addLocationButton.setTitleColor(.black, for: .normal)
        addLocationButton.layer.cornerRadius = 8
        addLocationButton.layer.masksToBounds = true
        addLocationButton.addTarget(self, action: #selector(toSetLocation), for: .touchUpInside)
    }
    
    @objc private func toSetLocation() {
        present(UINavigationController(rootViewController: setLocationViewController), animated: true)
    }
    
    private func setAddLocationText() {
        addLocationText.text = "위치 추가"
        addLocationText.font = UIFont.subHead
        self.stackView.addArrangedSubview(addLocationText)
    }
    
    private func setPlusLabel() {
        //일단 임의로 작성
        plusLabel.text = "+"
        plusLabel.font = UIFont.subHead
        plusLabel.textAlignment = .center
        self.stackView.addArrangedSubview(plusLabel)
    }
    
    private func setStackView() {
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
    
    private func setIdDescription() {
        idDescription.font = UIFont.caption2
        idDescription.textColor = UIColor.orange
    }
    
    
    private func setConstraints() {
        let addSubviewComponent = [idStackView, circleButton, contour, addLocationButton, idLabel, idTextField, idDescription]
        addSubviewComponent.forEach{self.view.addSubview($0)}
        self.addLocationButton.addSubview(stackView)
        
        let component = [circleButton, idStackView, contour, addLocationButton, plusLabel, addLocationText, idLabel, idTextField, idDescription, stackView, idTextField, idLabel]
        component.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 794
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        
        NSLayoutConstraint.activate([
            circleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            circleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 136*heightRatio),
            circleButton.widthAnchor.constraint(equalToConstant: 80),
            circleButton.heightAnchor.constraint(equalToConstant: 80),
            
            contour.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10.5*heightRatio),
            contour.heightAnchor.constraint(equalToConstant: 0.5*heightRatio),
            contour.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            contour.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            addLocationButton.topAnchor.constraint(equalTo: contour.bottomAnchor, constant: 40*heightRatio),
            addLocationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16*widthRatio),
            addLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16*widthRatio),
            addLocationButton.heightAnchor.constraint(equalToConstant: 52*heightRatio),
            
            stackView.centerXAnchor.constraint(equalTo: self.addLocationButton.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.addLocationButton.centerYAnchor),
            
            idLabel.topAnchor.constraint(equalTo: self.circleButton.bottomAnchor,constant: 35.0*heightRatio),
            idLabel.heightAnchor.constraint(equalToConstant: 22*heightRatio),
            idLabel.leadingAnchor.constraint(equalTo: idStackView.leadingAnchor, constant: 16*widthRatio),
            
            idTextField.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 52.74*widthRatio),
            idTextField.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            idTextField.heightAnchor.constraint(equalToConstant: 22*heightRatio),
            
            idDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16*widthRatio),
            idDescription.topAnchor.constraint(equalTo: contour.bottomAnchor, constant: 3*widthRatio),
        ])
    }
    
    
    
    
    
}

extension JoinViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //6글자 미만일 경우 디스크립션 텍스트 변경
        if (textField.text?.count ?? 0) + string.count < 6 {
            idDescription.text = "6~12자 이내로 입력하세요"
        }else {
            idDescription.text = ""
        }
        
        if string.isEmpty {
            //백스페이스 버튼은 무조건 허용
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
    
    private func isEnglishNumber(_ string: String) -> Bool {
        let englishNumber = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz1234567890")
        guard let scalar = UnicodeScalar(string) else {
            return false
        }
        return englishNumber.contains(scalar)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
