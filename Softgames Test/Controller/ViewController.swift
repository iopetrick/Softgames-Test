//
//  ViewController.swift
//  Softgames Test
//
//  Created by Pratikkumar Prajapati on 16/05/22.
//

import UIKit
import WebKit

final class ViewController: UIViewController {
    
    var viewModel: UserFormViewModel!
    
    private lazy var webView: WKWebView = {
        let contentController = WKUserContentController();
        contentController.add(self,name: self.viewModel.webkitInterfaceName)
        contentController.add(self,name: self.viewModel.webkitInterfacedob)
        
        let config = WKWebViewConfiguration()
        
        if let js = addJStoHtml() {
            var userScript:WKUserScript =  WKUserScript(source: js,
                                                        injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
                                                        forMainFrameOnly: false)
            contentController.addUserScript(userScript)
        }
        
        config.userContentController = contentController
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        let webview = self.webView
        self.view.addSubview(webview)
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        loadHtmlDocument()
    }
    
    func loadHtmlDocument() {
        guard let documentUrl = Bundle.main.url(forResource: "softgame_doc", withExtension: "html") else {
            debugPrint("softgame_doc.html not found in current bundle")
            return
        }
        let request = URLRequest(url: documentUrl)
        self.webView.load(request)
    }
    
    func addJStoHtml() -> String? {
        if let filePath = Bundle(for: ViewController.self).url(forResource: "ClickMeEventRegister",
                                                               withExtension:"js") {
            return try? String(contentsOf: filePath)
        }
        return nil
    }
    
    private func passValue(to javascript: String) {
        self.webView.evaluateJavaScript(javascript) { result, error in
            if let error = error {
                debugPrint(error)
                self.showAlert(message: error.localizedDescription)
                return
            }
        }
    }
    
}

extension ViewController: WKNavigationDelegate, WKScriptMessageHandler {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == self.viewModel.webkitInterfaceName) {
            self.viewModel.getDataFrom(dictionary: message.body as? [String: String?])
        } else if(message.name == self.viewModel.webkitInterfacedob) {
            if let dateString = message.body as? String {
                self.viewModel.showUserAge(date: dateString)
            }
        }
    }
}

extension ViewController: UserFormViewModelDelegate {
    
    func showError(message: String) {
        self.showAlert(message: message)
    }
    
    func sendUserAge(age: String) {
        self.passValue(to: "showUserAge('\(age)')")
    }
    
    func sendFullName(fullName: String) {
        self.passValue(to: "showFullName('\(fullName)')")
    }
}
