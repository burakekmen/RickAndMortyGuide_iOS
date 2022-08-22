//
//  WebViewBuilder.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit

enum WebViewBuilder {

    static func generate(
        title: String? = nil,
        url: String,
        modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
        dismissCallback: (() -> Void)? = nil
    ) -> BaseNavigationController {
        guard let url = URL(string: url) else {
            fatalError("undefined webview url")
        }
        return createWebViewNavigationController(title: title,
                                                 url: url, htmlContent: nil,
                                                 modalTransitionStyle: modalTransitionStyle,
                                                 dismissCallback: dismissCallback)
    }

    static func generate(
        title: String? = nil,
        htmlContent: String,
        modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
        dismissCallback: (() -> Void)? = nil
    ) -> BaseNavigationController {
        return createWebViewNavigationController(title: title,
                                                 url: nil, htmlContent: htmlContent,
                                                 modalTransitionStyle: modalTransitionStyle,
                                                 dismissCallback: dismissCallback)
    }

    private static func createWebViewNavigationController(title: String? = nil,
                                                          url: URL?,
                                                          htmlContent: String?,
                                                          modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
                                                          dismissCallback: (() -> Void)? = nil) -> BaseNavigationController {

        let webViewController = createWebViewController()
        webViewController.dismissCallback = dismissCallback
        webViewController.navTitle = title
        if let webUrl = url {
            webViewController.webUrl = webUrl
        } else if let htmlContent = htmlContent {
            webViewController.htmlContent = htmlContent
        }

        let controller = BaseNavigationController(rootViewController: webViewController)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = modalTransitionStyle
        return controller
    }

    private static func createWebViewController() -> WebViewViewController {
        let webViewController = WebViewViewController()
        webViewController.modalPresentationStyle = .fullScreen
        webViewController.modalTransitionStyle = .crossDissolve
        return webViewController
    }
}
