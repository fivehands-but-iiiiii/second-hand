//
//  GIthubWebViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/14.
//

import UIKit

class GithubWebViewController: UIViewController {
    
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        let url = URL(string: "https://github.com/login/oauth/authorize?client_id=aeceaccd71d24266b1d3&redirect_url=http://localhost:8080/login/oauth2/code/github")
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
