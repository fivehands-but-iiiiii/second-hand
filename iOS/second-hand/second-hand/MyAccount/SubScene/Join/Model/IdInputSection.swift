//
//  IdInputSection.swift
//  second-hand
//
//  Created by SONG on 2023/06/26.
//

import UIKit

final class IdInputSection: UIView {
    
    private var idLabel = UILabel()
    private var idTextField = UITextField()
    private var contour = UILabel()
    private var idConvention = UILabel()
    var idDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponenets()
        idTextField.delegate = self
        idTextField.autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponenets()
        idTextField.delegate = self
        idTextField.autocapitalizationType = .none
    }
    
    private func setupComponenets() {
        
        addSubview(contour)
        setContour()
        setupContourConstraints()
        
        addSubview(idLabel)
        setIdLabel()
        setupIdLabelConstraints()
        
        addSubview(idTextField)
        setIdTextField()
        setupIdTextFieldConstraints()
        
        addSubview(idConvention)
        setIdConvention()
        setupIdConventionConstraints()
        
        addSubview(idDescription)
        setIdDescription()
        setupIdDesriptionConstraints()
    }
    
    func setIdLabel() {
        idLabel.text = "아이디"
        idLabel.font = UIFont.body
    }
    
    func setIdTextField() {
        idTextField.placeholder = "아이디를 입력하세요"
        idTextField.font = UIFont.body
    }
    
    func setContour() {
        contour.backgroundColor = UIColor.neutralBorder
    }
    
    func setIdConvention() {
        idConvention.text = "아이디는 소문자와 숫자만 가능해요"
        idConvention.textAlignment = .right
        idConvention.font = UIFont.fontB
        idConvention.textColor = UIColor.neutralTextWeak
    }
    
    func setIdDescription() {
        idDescription.font = UIFont.fontB
        idDescription.textAlignment = .right
        idDescription.textColor = UIColor.orange
    }
    
    private func setupIdLabelConstraints() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                idLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20.0),
                idLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 47.26/393),
                idLabel.heightAnchor.constraint(equalTo: idLabel.widthAnchor, multiplier: 22/47.26),
                idLabel.bottomAnchor.constraint(equalTo: contour.topAnchor)
            ]
        )
    }
    
    private func setupIdTextFieldConstraints() {
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                idTextField.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 40),
                idTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                idTextField.heightAnchor.constraint(equalTo: idLabel.heightAnchor),
                idTextField.bottomAnchor.constraint(equalTo: contour.topAnchor)
            ]
        )
    }
    
    private func setupContourConstraints() {
        contour.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                contour.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                contour.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                contour.heightAnchor.constraint(equalToConstant: 1.0),
                contour.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ]
        )
    }
    
    private func setupIdConventionConstraints() {
        idConvention.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                idConvention.topAnchor.constraint(equalTo: contour.bottomAnchor,constant: 5.0),
                idConvention.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
                idConvention.heightAnchor.constraint(equalTo: idLabel.heightAnchor, multiplier: 0.5),
                idConvention.leadingAnchor.constraint(equalTo:self.leadingAnchor)
            ]
        )
    }
    
    private func setupIdDesriptionConstraints() {
        idDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                idDescription.topAnchor.constraint(equalTo: idConvention.bottomAnchor),
                idDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
                idDescription.heightAnchor.constraint(equalTo: idConvention.heightAnchor),
                idDescription.leadingAnchor.constraint(equalTo:self.leadingAnchor)
            ]
        )
    }
}

extension IdInputSection: UITextFieldDelegate {
    
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
    
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 0 {
            idDescription.text = ""
        }
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
