//
//  WebKit+Extensions.swift
//  RickAndMortyGuide
//
//

import WebKit

// MARK: WKWebView
extension WKWebView {
    
    func fitViewFrame() {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"

        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        self.configuration.userContentController.addUserScript(script)
    }
}
