//
//  BaseApiErrorHandler.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit

typealias CallbackOverrideAllErrorType = ((_ errorMessage: String) -> Void)

class BaseApiErrorHandler {

    private weak var viewController: UIViewController?
    /// bu callback kullanılırsa eğer, tüm hata tiplerinde bu callback'in
    /// içine yazdığınız kodlar çalışır, default alert gösterimi iptal olur.
    private var callbackOverrideAllErrorType: CallbackOverrideAllErrorType? = nil
    /// bu callback kullanılırsa eğer, ekrana basılan tüm alertlarda, tamam butonuna basıldığında
    /// bu callback'in içine yazdıklarınız çalışır.
    private var allTypeErrorAlertAction: (() -> Void)? = nil

    init(viewController: UIViewController?,
         callbackOverrideAllErrorType: CallbackOverrideAllErrorType?,
         allTypeErrorAlertAction: (() -> Void)?) {
        self.viewController = viewController
        self.callbackOverrideAllErrorType = callbackOverrideAllErrorType
        self.allTypeErrorAlertAction = allTypeErrorAlertAction
    }

    func handleHttp500(errorMessage: String) {
        if let callbackOverrideAllErrorType = callbackOverrideAllErrorType {
            callbackOverrideAllErrorType(errorMessage)
        } else {
            showDefaultAlert(errorMessage: errorMessage)
        }
    }

    func handleHttpElse(errorMessage: String) {
        if let callbackOverrideAllErrorType = callbackOverrideAllErrorType {
            callbackOverrideAllErrorType(errorMessage)
        } else {
            showDefaultAlert(errorMessage: errorMessage)
        }
    }

    func handleNoInternet(errorMessage: String) {
        if let callbackOverrideAllErrorType = callbackOverrideAllErrorType {
            callbackOverrideAllErrorType(errorMessage)
        } else {
            showDefaultAlert(errorMessage: errorMessage)
        }
    }

    func handleCommonError(errorMessage: String) {
        if let callbackOverrideAllErrorType = callbackOverrideAllErrorType {
            callbackOverrideAllErrorType(errorMessage)
        } else {
            showDefaultAlert(errorMessage: errorMessage)
        }
    }

    func handleDefaultError(errorMessage: String?) {
        if let callbackOverrideAllErrorType = callbackOverrideAllErrorType {
            callbackOverrideAllErrorType(errorMessage ?? "")
        } else {
            showDefaultAlert(errorMessage: errorMessage)
        }
    }

    private func showDefaultAlert(errorMessage: String?) {
        viewController?.showErrorAlert(errorMessage: errorMessage ?? "") { [weak self] in // positive button click
            self?.allTypeErrorAlertAction?()
        }
    }
}

/// Bu class ile isteğiniz herhanig bir hata tipini override edip, alert göstermek yerine kendi işleminizi yapabilirsiniz.
/// sadece kullandığınız callback sizin istediğiniz şekilde çalışır, diğerleri standart devam eder ve alert basar.
class CustomApiErrorHandler: BaseApiErrorHandler {

    private var callbackErrorHTTP500: ((String) -> Void)? = nil
    private var callbackErrorHTTPElse: ((String) -> Void)? = nil
    private var callbackErrorNoInternet: ((String) -> Void)? = nil
    private var callbackErrorCommon: ((String) -> Void)? = nil
    private var callbackErrorDefault: ((_ errorMessage: String?) -> Void)? = nil

    // OK action callback
    private var callbackOverrideAllErrorType: CallbackOverrideAllErrorType? = nil
    private var allTypeErrorAlertAction: (() -> Void)? = nil

    init(viewController: UIViewController? = nil,
         callbackErrorHTTP500: ((String) -> Void)? = nil,
         callbackErrorHTTPElse: ((String) -> Void)? = nil,
         callbackErrorNoInternet: ((String) -> Void)? = nil,
         callbackErrorCommon: ((String) -> Void)? = nil,
         callbackOverrideAllErrorType: CallbackOverrideAllErrorType? = nil,
         allTypeErrorAlertAction: (() -> Void)? = nil) {

        super.init(viewController: viewController,
                   callbackOverrideAllErrorType: callbackOverrideAllErrorType,
                   allTypeErrorAlertAction: allTypeErrorAlertAction)
        self.callbackErrorHTTP500 = callbackErrorHTTP500
        self.callbackErrorHTTPElse = callbackErrorHTTPElse
        self.callbackErrorNoInternet = callbackErrorNoInternet
        self.callbackErrorCommon = callbackErrorCommon
    }

    override func handleHttp500(errorMessage: String) {
        if let callbackErrorHTTP500 = callbackErrorHTTP500 {
            callbackErrorHTTP500(errorMessage)
        } else {
            super.handleHttp500(errorMessage: errorMessage)
        }
    }

    override func handleHttpElse(errorMessage: String) {
        if let callbackErrorHTTPElse = callbackErrorHTTPElse {
            callbackErrorHTTPElse(errorMessage)
        } else {
            super.handleHttpElse(errorMessage: errorMessage)
        }
    }

    override func handleNoInternet(errorMessage: String) {
        if let callbackErrorNoInternet = callbackErrorNoInternet {
            callbackErrorNoInternet(errorMessage)
        } else {
            super.handleNoInternet(errorMessage: errorMessage)
        }
    }

    override func handleCommonError(errorMessage: String) {
        if let callbackErrorCommon = callbackErrorCommon {
            callbackErrorCommon(errorMessage)
        } else {
            super.handleCommonError(errorMessage: errorMessage)
        }
    }

    override func handleDefaultError(errorMessage: String?) {
        if let callbackErrorDefault = callbackErrorDefault {
            callbackErrorDefault(errorMessage)
        } else {
            super.handleDefaultError(errorMessage: errorMessage)
        }
    }
}
