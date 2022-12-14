//
//  NativeProgressView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit

class NativeProgressView: BaseReusableView {

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .whiteColor
        activityIndicator.hidesWhenStopped = true

        addSubview(activityIndicator)
        return activityIndicator
    }()

    override func initializeSelf() {
        alpha = 0
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupViews()
    }

    func playAnimation(isPlay: Bool) {
        if isPlay {
            playAnimation()
        } else {
            stopAnimation()
        }
    }

    func playAnimation(isPlay: Bool, parentView: UIView?) {
        if isPlay {
            playAnimation(parentView: parentView)
        } else {
            stopAnimation()
        }
    }

    func playAnimation() {
        if let window = WindowHelper.getWindow() {
            window.addSubview(self)
            self.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
            window.bringSubviewToFront(self)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.alpha = 1.0
            }
            activityIndicator.startAnimating()
        }
    }

    func playAnimation(parentView: UIView?) {
        if let parentView = parentView {
            parentView.addSubview(self)
            self.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
            parentView.bringSubviewToFront(self)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.alpha = 1.0
            }
            activityIndicator.startAnimating()
        }
    }

    func stopAnimation() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.alpha = 0
        } completion: { [weak self] completed in
            self?.removeFromSuperview()
            self?.activityIndicator.stopAnimating()
        }
    }
}

private extension NativeProgressView {

    func setupViews() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
}


