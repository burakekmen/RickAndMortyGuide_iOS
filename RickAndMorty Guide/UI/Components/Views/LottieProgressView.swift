//
//  LottieProgressView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit
import Lottie
import SnapKit

class LottieProgressView: BaseReusableView {

    private lazy var animationView: AnimationView = {
        let view = AnimationView(nameKey: .lottie_anim_progress_loading)
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop

        addSubview(view)
        return view
    }()

    override func initializeSelf() {
        alpha = 0
        backgroundColor = .clearColor
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
            animationView.play()
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
            animationView.play()
        }
    }

    func stopAnimation() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.alpha = 0
        } completion: { [weak self] completed in
            self?.removeFromSuperview()
            self?.animationView.stop()
        }
    }
}

private extension LottieProgressView {

    func setupViews() {
        addSubview(animationView)
        animationView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.equalTo(CGFloat(200).adjustWidthRespectToDesignRate())
            maker.height.equalTo(CGFloat(175).adjustHeightRespectToDesignRate())
        }
    }
}

