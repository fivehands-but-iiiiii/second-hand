//
//  RegionViewController.swift
//  second-hand
//
//  Created by SONG on 2023/08/30.
//

import UIKit

class RegionSearchingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        self.view.backgroundColor = .white
    }
    
    @objc func backButtonTapped() {

}

extension RegionSearchingViewController: UICollectionViewDelegate {
        
    }
    
        let body = JSONCreater().createChangingRegionBody(region)
        
    }
}
