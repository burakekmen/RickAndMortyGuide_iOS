//
//  UIStackView+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UIStackView {
    static func createStackView(axis: NSLayoutConstraint.Axis = .vertical,
                                distribution: UIStackView.Distribution = .fillEqually,
                                spacing: CGFloat = 0) -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = distribution
        stackView.axis = axis
        stackView.spacing = spacing
        return stackView
    }
}


