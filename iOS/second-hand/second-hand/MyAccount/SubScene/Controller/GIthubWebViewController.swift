//
//  GIthubWebViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/14.
//

import UIKit

class GIthubWebViewController: UIViewController {
    
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        let url = URL(string: "http://www.naver.com")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        
    }
    
    func layout() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        webView.topAnchor.constraint(equalTo: self.view.topAnchor),
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
