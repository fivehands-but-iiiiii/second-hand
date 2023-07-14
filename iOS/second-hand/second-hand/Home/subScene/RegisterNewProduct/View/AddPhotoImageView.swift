//
//  AddPhotoImageView.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/09.
//

import UIKit

final class AddPhotoImageView: UIImageView {

    lazy var cancelButton = UIButton()
    private let titlePhotoLabel = UILabel()
    private let cancelButtonSize: CGFloat = 28
    
    
    override init(image: UIImage?) {
        super.init(image: image)
        setTitlePhotoLabel()
        setUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTitlePhotoLabel()
        setUI()
        layout()
        
    }
    
    private func setTitlePhotoLabel() {
        titlePhotoLabel.backgroundColor = .neutralOveray
        titlePhotoLabel.textColor = .neutralBackground
        titlePhotoLabel.font = .systemFont(ofSize: 11)
        titlePhotoLabel.text = "대표 사진"
        titlePhotoLabel.textAlignment = .center
    }
    
    private func setUI() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        // cancelButton 설정
        cancelButton.setTitle("X", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 14)
        cancelButton.backgroundColor = .black
        cancelButton.layer.cornerRadius = cancelButtonSize/2
        cancelButton.layer.masksToBounds = true
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .allEvents)
        
    }
    
    private func layout() {
        [cancelButton, titlePhotoLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        NSLayoutConstraint.activate([
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            cancelButton.widthAnchor.constraint(equalToConstant: cancelButtonSize),
            cancelButton.heightAnchor.constraint(equalToConstant: cancelButtonSize)
        ])
        
        // titlePhotoLabel 레이아웃 설정
        // 첫번째 사진만 레이블을 입히 수 있도록 설정
        titlePhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titlePhotoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            titlePhotoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            titlePhotoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            titlePhotoLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func cancelButtonTapped() {
        removeFromSuperview()
        removeImageFromScrollView()
    }
    
    private func removeImageFromScrollView() {
        guard let scrollView = superview as? AddPhotoScrollView else { return }
        
        for subview in scrollView.addPhotoStackView.arrangedSubviews {
            if subview == self {
                scrollView.addPhotoStackView.removeArrangedSubview(subview)
                subview.removeFromSuperview()
                break
            }
        }
    }
}
