//
//  UIApplication+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UIApplication {

    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }

    static func topViewController() -> UIViewController? {
        return WindowHelper.getWindow()?.topMostViewController()
    }
}
