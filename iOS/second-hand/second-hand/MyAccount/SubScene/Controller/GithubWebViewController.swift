//
//  GIthubWebViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/14.
//

import UIKit
import WebKit

class GithubWebViewController: UIViewController {
    
    var webView = UIWebView()
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        webViewLogic()
    }
    
    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
        webView.topAnchor.constraint(equalTo: self.view.topAnchor),
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func webViewLogic() {
        let url = URL(string: "https://github.com/login/oauth/authorize?client_id=aeceaccd71d24266b1d3&redirect_url=http://localhost:8080/login/oauth2/code/github")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
extension GithubWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            handleRedirectURL(url: url)
        }
        decisionHandler(.allow)
    }
}
