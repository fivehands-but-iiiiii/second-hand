//
//  SaleLogViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class SaleLogViewController: UIViewController {
    let titleLabel = UILabel()
    let segmentControl = UISegmentedControl(items: ["판매중", "판매완료"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "판매 내역"
        setNavigationBar()
        setSegmentControl()
    }
    
    func setSegmentControl() {
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        segmentControlLayout()
    }
    
    func setNavigationBar() {
        navigationController?.navigationBar.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 100))
        
        guard let navigationBar = navigationController?.navigationBar else {return}
        let borderView = UIView(frame: CGRect(x: .zero, y: navigationBar.frame.maxY, width: navigationBar.frame.width, height: 1))
        
        borderView.backgroundColor = .lightGray
        navigationBar.addSubview(borderView)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        
        //let selectedIndex = sender.selectedSegmentIndex
        // 선택된 인덱스에 따라 원하는 동작 수행
    }
    
    func segmentControlLayout() {
        self.view.addSubview(segmentControl)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 794
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 102*heightRatio),
            segmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            segmentControl.widthAnchor.constraint(equalToConstant: 240*widthRatio),
            segmentControl.heightAnchor.constraint(equalToConstant: 32*heightRatio)
        ])
    }
}

