//
//  UIBarButtonItem+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UIBarButtonItem {

    func addClickAction(_ target: AnyObject?, action: Selector) {
        self.target = target
        self.action = action
    }
}

extension UIBarButtonItem {

    static func createCloseCrossButton(clickHandler: @escaping (() -> Void)) -> UIBarButtonItem {
        return UIBarButtonItem(image: .iconCross, style: .plain, handler: { _ in
            clickHandler()
        })
    }

    static func generateBackButtonLikeOrginalNavigationBar(tapGesture: @escaping (UITapGestureRecognizer) -> Void) -> UIBarButtonItem {
        let backButton = UIButton(type: .system)
        backButton.setTitle(fetchLocalizeString(key: .str_back), for: .normal)
        backButton.setTitleColor(.blackColor, for: .normal)

        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.imageEdgeInsets.left = -16

        backButton.onTap(tapGesture)

        return UIBarButtonItem(customView: backButton)
    }
}


