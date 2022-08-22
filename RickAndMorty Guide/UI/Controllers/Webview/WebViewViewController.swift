//
//  WebViewViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKUIDelegate {

    private var progressView: LottieProgressView?
    var webView: WKWebView!
    var navTitle: String? = nil
    var webUrl: URL? = nil
    var htmlContent: String? = nil

    // MARK: Callback
    var dismissCallback: (() -> Void)?

    private lazy var closeBarButton: UIBarButtonItem = {
        return UIBarButtonItem.createCloseCrossButton(
            clickHandler: { [weak self] in
                self?.selfDismiss()
                self?.dismissCallback?()
            })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor
        progressView = LottieProgressView()
        self.navigationItem.leftBarButtonItem = closeBarButton

        if let navTitle = navTitle {
            self.navigationItem.title = navTitle
        }

        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        // TODO: Zoomable enable
        // webView.scrollView.minimumZoomScale = 1.0
        // webView.scrollView.maximumZoomScale = 5.0
        webView.fitViewFrame()

        if let webUrl = webUrl {
            playLottieLoading(isLoading: true)
            self.openUrlWebView(url: webUrl)
        } else if let htmlContent = htmlContent {
            self.webView.loadHTMLString(htmlContent, baseURL: nil)
        }
    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        // webView.navigationDelegate = self // WKNavigationDelegate
        webView.uiDelegate = self
        view = webView
    }

    private func openUrlWebView(url: URL) {
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            self.playLottieLoading(isLoading: webView.isLoading)
        }
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

// MARK: Lottie Progress View
extension WebViewViewController {

    func playLottieLoading(isLoading: Bool) {
        if isLoading {
            progressView?.playAnimation(parentView: self.view)
        } else {
            progressView?.stopAnimation()
        }
    }
}
