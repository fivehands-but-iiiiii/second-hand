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
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func startOAuthFlow() {
        let authURLString = "https://github.com/login/oauth/authorize?client_id=5c4b10099c0ae232e5a1&redirect_url=http://localhost:5173/login/oauth2/code/github"
        
        if let authURL = URL(string: authURLString) {
            let authRequest = URLRequest(url: authURL,timeoutInterval: 10.0) // 예처
            webView.load(authRequest)
        }
    }
extension GithubWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            handleRedirectURL(url: url)
        }
        decisionHandler(.allow)
    }
}


//// MARK: - 에러처리 일단 주석 
//
//extension GithubWebViewController {
//    private func handleNetworkServiceError(with statusCode: Int) {
//        let errorStatusCode = ManagerErrors.statuscode(rawValue: statusCode)
//
//        switch errorStatusCode {
//        case .internalServerError:
//            // something => 500번대 에러에 대한 처리
//        case .notFound:
//            // something => => 사용자한테 표시해야하는 에러
//        }
//    }
//}
