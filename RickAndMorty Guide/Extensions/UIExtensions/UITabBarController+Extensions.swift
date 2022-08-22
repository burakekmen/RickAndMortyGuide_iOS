//
//  UITabBarController+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UITabBarController {

    open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }

    func removeAllTitle() {
        if let tab = self.tabBar.items, let currentTab = self.selectedViewController {
            tab.forEach {
                if currentTab != self {
                    $0.title = ""
                }
            }
        }
    }

    func setTabBarVisible(visible: Bool, duration: TimeInterval, animated: Bool) {
        if (tabBarIsVisible() == visible) { return }
        let tabBarFrame = self.tabBar.frame
        let height = tabBarFrame.size.height + 16
        let offsetY = (visible ? -height : height)

        if visible {
            self.tabBar.isHidden = false
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.tabBar.isHidden = true
            }
        }

        // animation
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            let tabbarOffset = self.tabBar.frame.offsetBy(dx: 0, dy: offsetY)
            self.tabBar.frame = tabbarOffset
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }.startAnimation()

    }

    func tabBarIsVisible() -> Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }

}
