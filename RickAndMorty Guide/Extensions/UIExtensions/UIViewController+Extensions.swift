//
//  UIViewController+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit
import SafariServices
import Localize

extension UIViewController {

    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    static func instantiateFromNibOrSelfIntance() -> Self {
        func instantiateFromNibOrSelfIntance<T: UIViewController>(_ viewType: T.Type) -> T {
            guard let _ = Bundle.main.path(forResource: String(describing: T.self), ofType: "nib") else {
                return T.init()
            }
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNibOrSelfIntance(self)
    }

    func hideKeyboard() {
        self.view.hideKeyboard()
    }

    // back title'ı değiştirmek istediğiniz sayfanın bir önceki sayfasında bunu çağırmalısınız.
    func setBackButtonTitle(title: String) {
        let backButton = BackBarButtonItem(title: title, style: .plain)
        backButton.tintColor = navigationController?.navigationBar.tintColor
        navigationItem.backBarButtonItem = backButton
    }

    func setBackButtonTitle(titleKey: GeneralLocalizeKeys) {
        let backButton = BackBarButtonItem(titleKey: titleKey, style: .plain)
        backButton.tintColor = navigationController?.navigationBar.tintColor
        navigationItem.backBarButtonItem = backButton
    }

    func visibleTabBar(isVisible: Bool) {
        self.tabBarController?.tabBar.isHidden = !isVisible
    }

    func visibleNavigationBar(isVisible: Bool, animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(!isVisible, animated: animated)
    }

    func openUrl(url: String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    func openSFSafariViewController(url: String) {
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }

    func transitionViewController(vc: UIViewController, duration: CFTimeInterval = 0.5, type: CATransitionSubtype) {
        let customVcTransition = vc
        let transition = createTransitionAnimation(duration: duration, type: type)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(customVcTransition, animated: false, completion: nil)
    }

    func transitionDismiss(duration: CFTimeInterval = 0.3, type: CATransitionSubtype) {
        let transition = createTransitionAnimation(duration: duration, type: type)
        view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }

    private func createTransitionAnimation(duration: CFTimeInterval, type: CATransitionSubtype) -> CATransition {
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.push
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        return transition
    }

    func presentViewController(_ viewControllerToPresent: UIViewController) {
        self.present(viewControllerToPresent, animated: true, completion: nil)
    }

    func pushViewControllerToNavigationController(_ viewControllerToPresent: UIViewController, isAnimated: Bool = true) {
        self.navigationController?.pushViewController(viewControllerToPresent, animated: isAnimated)
    }

    func selfDismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    func selfPopViewController(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }

    func selfPopToRootViewController(animated: Bool = false) {
        self.navigationController?.popToRootViewController(animated: animated)
    }

}

enum AlertPreferredActionType {
    case positive
    case negative
    case nothing
}

// MARK: Alert
extension UIViewController {

    func showInformationAlert(
        message: String,
        positiveButtonClickListener: (() -> Void)? = nil) {

        showSystemAlert(title: fetchLocalizeString(key: .str_information),
                        message: message,
                        positiveButtonClickListener: positiveButtonClickListener)
    }

    func showSuccessAlert(
        message: String,
        positiveButtonClickListener: (() -> Void)? = nil) {

        showSystemAlert(title: fetchLocalizeString(key: .str_success),
                        message: message,
                        positiveButtonClickListener: positiveButtonClickListener)
    }

    func showErrorAlert(
        errorMessage: String,
        positiveButtonClickListener: (() -> Void)? = nil) {

        showSystemAlert(title: fetchLocalizeString(key: .str_error),
                        message: errorMessage,
                        positiveButtonClickListener: positiveButtonClickListener)
    }

    func showWarningAlert(
        message: String,
        positiveButtonClickListener: (() -> Void)? = nil) {

        showSystemAlert(title: fetchLocalizeString(key: .str_warning),
                        message: message,
                        positiveButtonClickListener: positiveButtonClickListener)
    }

    func showSystemAlert(
        title: String,
        message: String,
        positiveButtonText: String? = "str_ok".localize(),
        positiveButtonClickListener: (() -> Void)? = nil,
        negativeButtonText: String? = nil,
        negativeButtonClickListener: (() -> Void)? = nil,
        preferredActionType: AlertPreferredActionType = .nothing,
        tintColor: UIColor = .orangeColor
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = tintColor

        // Positive Action
        let posAction = UIAlertAction(title: positiveButtonText, style: .default,
                                      handler: { _ in
                                          positiveButtonClickListener?()
                                      })
        alert.addAction(posAction)

        // Negative Action
        var negAction: UIAlertAction? = nil
        if let negativeButtonText = negativeButtonText {
            negAction = UIAlertAction(title: negativeButtonText, style: .cancel,
                                      handler: { _ in
                                          negativeButtonClickListener?()
                                      })
            alert.addAction(negAction!)
        }

        switch preferredActionType {
        case .positive:
            alert.preferredAction = posAction
        case .negative:
            alert.preferredAction = negAction
        case .nothing:
            alert.preferredAction = nil
        }

        present(alert, animated: true, completion: nil)

    }
}

// MARK: Toast Messages
extension UIViewController {

    func showToast(message: String, position: ToastPosition = .bottom, messageAligment: NSTextAlignment = .left) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.darkGray
        style.messageColor = UIColor.white
        style.messageAlignment = messageAligment
        self.view.makeToast(message, position: position, style: style)
    }
}

// MARK: Embed Container
extension UIViewController {

    func embed(_ vc: UIViewController, in _containerView: UIView? = nil) {
        let containerView: UIView = _containerView ?? view // Use the whole view if no container view is provided.
        containerView.addSubview(vc.view)
        NSLayoutConstraint.activate([
            vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        ])
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        vc.didMove(toParent: self)
    }
}
