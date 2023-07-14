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
    private let cancleButtonSize: CGFloat = 28
    
    
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
    }
    
    private func setUI() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        // cancelButton 설정
        cancelButton.setTitle("X", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 14)
        cancelButton.backgroundColor = .black
        cancelButton.layer.cornerRadius = cancleButtonSize/2
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
            cancelButton.widthAnchor.constraint(equalToConstant: cancleButtonSize),
            cancelButton.heightAnchor.constraint(equalToConstant: cancleButtonSize)
        ])
        
        // titlePhotoLabel 레이아웃 설정
        titlePhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titlePhotoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titlePhotoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            titlePhotoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            titlePhotoLabel.heightAnchor.constraint(equalToConstant: 20)
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
