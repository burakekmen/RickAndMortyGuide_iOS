//
//  SplashViewModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Bond
import ReactiveKit

protocol ISplashViewModel: AnyObject {

    var _viewState: ScreenStateSubject<SplashViewState> { get }
    var _actionState: ScreenStateSubject<SplashActionState> { get }

    init(repository: ISplashRepository,
         coordinator: ISplashCoordinator,
         uiModel: ISplashUIModel)
    
    func initializeView()
}

final class SplashViewModel: BaseViewModel, ISplashViewModel {

    // MARK: Definitions
    private let repository: ISplashRepository
    private let coordinator: ISplashCoordinator
    private var uiModel: ISplashUIModel

    // MARK: Private Props
    private let viewState = ScreenStateSubject<SplashViewState>()
    private let actionState = ScreenStateSubject<SplashActionState>()

    // MARK: Public Props
    var _viewState: ScreenStateSubject<SplashViewState> { viewState }
    var _actionState: ScreenStateSubject<SplashActionState> { actionState }

    // MARK: Initiliazer
    required init(repository: ISplashRepository,
                  coordinator: ISplashCoordinator,
                  uiModel: ISplashUIModel) {
        self.repository = repository
        self.coordinator = coordinator
        self.uiModel = uiModel
    }

    func initializeView() {
//        viewStateShowProgressLoading(isProgress: true)
//        DispatchQueue.delay(1000) { [unowned self] in
//            viewStateShowProgressLoading(isProgress: false)
            viewStatetartMainFlow()
//        }
    }
}


// MARK: Service
internal extension SplashViewModel {

}

// MARK: States
internal extension SplashViewModel {

    // MARK: View State
    func viewStateShowProgressLoading(isProgress: Bool) {
        self.viewState.on(.next(.showLoadingProgress(isProgress: isProgress)))
    }

    func viewStatetartMainFlow() {
        self.viewState.on(.next(.startMainFlow))
    }
    // MARK: Action State

}

// MARK: Coordinate
internal extension SplashViewModel {

}


enum SplashViewState {
    case showLoadingProgress(isProgress: Bool)
    case startMainFlow
}

enum SplashActionState {

}


