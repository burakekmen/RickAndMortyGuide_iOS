//
//  UIImageView+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }

    func downloadImage(imageUrl: String?, isSmallPlaceHolder: Bool = false, downloadedCallback: (() -> Void)? = nil) {
        let placeholder = UIImage(named: isSmallPlaceHolder ? "empty_image_place_holder_small" : "empty_image_place_holder")
        downloadImage(imageUrl: imageUrl,
                      placeHolderImage: placeholder,
                      errorHolderImage: placeholder,
                      downloadedCallback: downloadedCallback)
    }

    func downloadImage(imageUrl: String?,
                       placeHolderImage: UIImage? = UIImage(named: "empty_image_place_holder"),
                       errorHolderImage: UIImage? = UIImage(named: "empty_image_place_holder"),
                       downloadedCallback: (() -> Void)? = nil) {
        if let imageUrl = imageUrl {
            let url = URL(string: imageUrl)
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url,
                             placeholder: placeHolderImage,
                             options: [.transition(.fade(0.3)), .cacheOriginalImage],
                             progressBlock: nil) { (error) in
                switch error {
                case .success(_): downloadedCallback?()
                case .failure(_): self.image = errorHolderImage
                }
            }
        } else {
            image = placeHolderImage
        }
    }

}

extension UIImageView {

    func enablePinchZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }

    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}
