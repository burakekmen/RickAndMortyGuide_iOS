//
//  UIActivityIndicatorView.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UIActivityIndicatorView {

    func showActivityIndicator(isProgress: Bool) {
        if isProgress {
            self.startAnimating()
        } else {
            self.stopAnimating()
        }
    }
}

