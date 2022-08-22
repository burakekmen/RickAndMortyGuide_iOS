//
//  UINavigationController+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UINavigationController {
    
    var lastViewController: UIViewController? {
        return viewControllers.last
    }
    
    public var navigationBarHeight: CGFloat {
        return navigationBar.height
    }

    public var navigationBarWidth: CGFloat {
        return navigationBar.width
    }
    
    func setRootViewController(viewController: UIViewController) {
        self.viewControllers = [viewController]
    }

    /* func refreshTitleWith(title: String, font: UIFont? = nil, color: UIColor? = nil) {
        navigationBar.isTranslucent = false

        let font: UIFont = font ?? .SFProTextBold(fontSize: 17)
        let color: UIColor = color ?? .midGreen

        let textAttributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: font
        ]
        if let vc = self.viewControllers.last {
            vc.navigationController?.navigationBar.titleTextAttributes = textAttributes
            vc.title = title
        }
    }

    func refreshBackButtonTitle(title: String) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        backButton.tintColor = .midGreen
        if let vc = self.viewControllers.last {
            vc.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
    } */

    /**
     Pop current view controller to previous view controller.

     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func popWithAnimation(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.5) {
        self.addTransition(transitionType: type, duration: duration)
        self.popViewController(animated: false)
    }

    /**
     Push a new view controller on the view controllers's stack.

     - parameter vc:       view controller to push.
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func pushWithAnimation(viewController vc: UIViewController, transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(vc, animated: false)
    }

    private func addTransition(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.5) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }
}
