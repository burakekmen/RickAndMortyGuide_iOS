//
//  SplashViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit
import ReactiveKit
import Bond

final class SplashViewController: RAMBaseViewController {

    // MARK: Constants

    // MARK: Inject
    private let viewModel: ISplashViewModel

    // MARK: IBOutlets
    
    // MARK: Constraints Outlets
    
    // MARK: Initializer
    init(viewModel: ISplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SplashViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func initialComponents() {
        self.observeReactiveDatas()
        
        self.viewModel.initializeView()
    }

    override func registerEvents() {

    }

    private func observeReactiveDatas() {
        observeViewState()
        observeActionState()
        // listenErrorState()
    }

    private func observeViewState() {
        viewModel._viewState.observeNext { [unowned self] state in
            switch state {
            case .showLoadingProgress(let isProgress):
                self.playLottieLoading(isLoading: isProgress)
            case .startMainFlow:
                self.appDelegate.startFlowMain()
            }
        }.dispose(in: disposeBag)    
    }

    private func observeActionState() {
        /* viewModel._actionState.observeNext { [unowned self] state in
             switch state {
            
            } 
        }.dispose(in: disposeBag) */
    }

    private func listenErrorState() {
        // observeErrorState(errorState: viewModel._errorState)
    }

    // MARK: Define Components (if you have or delete this line)
}

// MARK: Props
private extension SplashViewController {
    
}
