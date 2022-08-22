//
//  RAMBaseViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit
import ReactiveKit

class RAMBaseViewController: UIViewController {

    deinit {
        print("killed: \(type(of: self))")
    }

    private let attributedTitleLabelTag: Int = 1995

    internal var disposeBag = DisposeBag()

    private var lottieProgressView: LottieProgressView?
    private var nativeProgressView: NativeProgressView?

    // if you want to 'show', override and set to true
    public var isShowNavBarLogo: Bool {
        return false
    }

    // if you want to 'hide', override and set to false
    public var isShowNavigationbar: Bool {
        return true
    }

    public var navigationTitle: String? {
        return nil
    }

    public var navigationTitleKey: GeneralLocalizeKeys? {
        return nil
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        initDidLoad()
    }

    // just base sub class
    internal func initDidLoad() {
        initNavigationBarBackButton()
        lottieProgressView = LottieProgressView()
        nativeProgressView = NativeProgressView()
        self.setupView()
        self.initialComponents()
        self.registerEvents()
    }

    private func initNavigationBarBackButton() {
        setBackButtonTitle(titleKey: .str_back)
        if #available(iOS 14.0, *) {
            // closed long press context menu
            navigationItem.backButtonDisplayMode = .minimal
        }
    }

    // for all sub class
    func setupView() { }

    // for all sub class
    func initialComponents() { }

    // for all sub class
    func registerEvents() { }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // General Configuration
        visibleNavigationBar(isVisible: isShowNavigationbar)
        
        if let findLabel = (self.navigationItem.titleView as? UILabel),
            findLabel.tag == attributedTitleLabelTag {
            // nothing here now
        } else {
            navigationItem.titleView = nil
            if let navTitleKey = navigationTitleKey {
                self.navigationItem.title = navTitleKey.make()
            } else if let navTitle = navigationTitle {
                self.navigationItem.title = navTitle
            }
        }
        /* if let navSubTitle = navigationSubTitle {
            // ileride, bunun için custom view eklenecek.
        } */
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: Props
internal extension RAMBaseViewController {

    func changeNavigationBarTitle(mTitle: String) {
        self.navigationItem.title = mTitle
    }

    /// if you want to use attributed features, you should use this method.(you need to some delay)
    /// - Parameters:
    ///   - mTitle: Title
    ///   - font: Title Font
    ///   - color: Title Color
    func setNavigationAttributedTitle(mTitle: String,
                                      font: UIFont = .systemFont(ofSize: 17, weight: .semibold),
                                      color: UIColor = .black) {
        let titleLabel = UILabel()
        titleLabel.tag = attributedTitleLabelTag
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        let titleRange = 0.toNSRange(length: mTitle.count)
        titleLabel.attributedText = mTitle.toNSMutableAttributedString()
            .addAttributeFont(font, range: titleRange)
            .addAttributeForegroundColor(color, range: titleRange)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }

    /// if you want to change attributed feaures for certainText, you should use this method but
    /// you have to firstly use 'setNavigationAttributedTitle' method or you have to have normal title. (you need to some delay)
    /// - Parameters:
    ///   - certainText: part of full text
    ///   - font: part of text font
    ///   - color: part of text color
    func changeNavigationCertainTextAttributedTitle(certainText: String, font: UIFont, color: UIColor) {
        if let findLabel = (self.navigationItem.titleView as? UILabel),
            findLabel.tag == attributedTitleLabelTag {
            if let currentAttributedText = findLabel.attributedText {
                let rangeOfText = currentAttributedText.string.findRangeOf(certainText: certainText)
                findLabel.attributedText = NSMutableAttributedString(attributedString: currentAttributedText)
                    .addAttributeFont(font, range: rangeOfText)
                    .addAttributeForegroundColor(color, range: rangeOfText)
            }
            findLabel.sizeToFit()
        } else {
            if let normalTitle = self.navigationItem.title {
                self.setNavigationAttributedTitle(mTitle: normalTitle)
                self.changeNavigationCertainTextAttributedTitle(certainText: certainText, font: font, color: color)
            }
        }
    }

}

// MARK: Lottie Progress View
extension RAMBaseViewController {

    func playLottieLoading(isLoading: Bool) {
        if isLoading {
            playLottieLoading()
        } else {
            stopLottieLoading()
        }
    }

    func playLottieLoading() {
        lottieProgressView?.playAnimation()
    }

    func stopLottieLoading() {
        lottieProgressView?.stopAnimation()
    }
}

// MARK: Native Progress View
extension RAMBaseViewController {

    func playNativeLoading(isLoading: Bool) {
        if isLoading {
            playNativeLoading()
        } else {
            stopNativeLoading()
        }
    }

    func playNativeLoading() {
        nativeProgressView?.playAnimation()
    }

    func stopNativeLoading() {
        nativeProgressView?.stopAnimation()
    }
}


// MARK: Rest API & Graph API Base
extension RAMBaseViewController {
    func observeErrorState(
        errorState: ErrorStateSubject,
        allTypeErrorAlertAction: (() -> Void)? = nil,
        apiErrorHandler: BaseApiErrorHandler? = nil,
        callbackOverrideAllErrorType: CallbackOverrideAllErrorType? = nil,
        runBlockBeforeError: (() -> Void)? = nil
    ) {
        var errorHandler = apiErrorHandler
        if errorHandler == nil {
            errorHandler = BaseApiErrorHandler(viewController: self,
                                               callbackOverrideAllErrorType: callbackOverrideAllErrorType,
                                               allTypeErrorAlertAction: allTypeErrorAlertAction)
        }
        errorState
            .receive(on: ExecutionContext.immediateOnMain)
            .observeNext(with: { [unowned self] (state) in
            switch state {
            case .Error(let errorType):
                runBlockBeforeError?()
                self.handleApiError(errorType: errorType, apiErrorHandler: errorHandler!)
            case .ErrorComplete: print("")
            }
        }).dispose(in: self.disposeBag)
    }

    func handleApiError(
        errorType: NetworkingError,
        apiErrorHandler: BaseApiErrorHandler
    ) {
        switch errorType {
        case .HTTP_EXCEPTION(let statusCode, _):
            if statusCode == 500 {
                apiErrorHandler.handleHttp500(errorMessage: errorType.description)
            } else {
                apiErrorHandler.handleHttpElse(errorMessage: errorType.description)
            }
        case .NO_CONNECTION_NETWORK:
            apiErrorHandler.handleNoInternet(errorMessage: errorType.description)
        case .TIMED_OUT_ERROR,
             .UNDEFINED_RESPONSE_TYPE:
            apiErrorHandler.handleCommonError(errorMessage: errorType.description)
        case .DEFAULT_ERROR(let message):
            apiErrorHandler.handleDefaultError(errorMessage: message)
        }
    }

}

// bilerek burada bırakıldı.
// MARK: UIViewController
extension UIViewController {
    var isViewAppeared: Bool { viewIfLoaded?.isAppeared == true }
}

// MARK: UIView
extension UIView {
    var isAppeared: Bool { window != nil }
}
