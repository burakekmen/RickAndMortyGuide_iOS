//
//  UIView+GradientExtensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

enum MKGridentEnum {
    case horizontal
    case vertical
}

extension UIView {

    static let gradientLayerName: String = "gradientLayer"

    func addGradientLayer(colors: [UIColor], type: MKGridentEnum, estimatedFrame: CGRect? = nil) {
        clipsToBounds = true

        if let sublayers = self.layer.sublayers {
            for sublayer in sublayers {
                if sublayer.name == UIView.gradientLayerName {
                    updateGradientLayer(estimatedFrame: estimatedFrame)
                    return
                }
            }
        }

        let gradient = CAGradientLayer()
        gradient.name = UIView.gradientLayerName
        gradient.frame = estimatedFrame ?? bounds
        gradient.colors = colors.map { $0.cgColor }

        switch type {
        case MKGridentEnum.horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)
        case MKGridentEnum.vertical:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
        }

        gradient.cornerRadius = layer.cornerRadius

        layer.insertSublayer(gradient, at: 0)
    }

    func updateGradientLayer(estimatedFrame: CGRect? = nil) {
        guard let sublayers = layer.sublayers else { return }

        for sublayer in sublayers {
            if sublayer.name == UIView.gradientLayerName {
                sublayer.frame = estimatedFrame ?? bounds
                sublayer.cornerRadius = layer.cornerRadius
            }
        }
    }

    func removeGradientLayer() {
        guard let sublayers = self.layer.sublayers else { return }

        for sublayer in sublayers {
            if sublayer.name == UIView.gradientLayerName {
                sublayer.removeFromSuperlayer()
            }
        }
    }

}
