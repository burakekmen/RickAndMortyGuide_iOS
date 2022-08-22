//
//  FavoritesViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 2.08.2022.
//

import UIKit
import ReactiveKit
import Bond
import Lottie

final class FavoritesViewController: MainBaseViewController {

    // MARK: Constants
    override var isShowTabbar: Bool {
        return true
    }

    // MARK: Inject
    private let viewModel: IFavoritesViewModel

    // MARK: IBOutlets
    @IBOutlet weak var charactersView: CharactersView!
    @IBOutlet weak var animationView: AnimationView!
    
    // MARK: Constraints Outlets
    
    // MARK: Initializer
    init(viewModel: IFavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "FavoritesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        self.setupAnimationView()
        self.setupCharactersView()
        
        self.viewModel.reloadFavoriteTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        self.animationView.stop()
    }

    override func setupView() {
        self.animationView.onTap { [unowned self] _ in
            self.showToast(message: "You guys, are the most worst!")
        }
    }
    
    override func initialComponents() {
        self.observeReactiveDatas()
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
            case .reloadTableView:
                let favoriteCharacters = UserManager.shared.getFavorites()
                
                if favoriteCharacters.isNotEmpty {
                    self.animationView?.stop()
                    self.animationView?.isHidden = true
                    self.charactersView.isHidden = false
                    self.charactersView.characters = favoriteCharacters
                }else {
                    self.animationView?.play()
                    self.charactersView.isHidden = true
                    self.animationView?.isHidden = false
                }
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
private extension FavoritesViewController {
    private func setupCharactersView() {
        self.charactersView.outputDelegate = self
        self.charactersView.canEditableTable = true
    }
    
    private func setupAnimationView() {
        self.animationView.loopMode = .loop
        self.animationView.animationSpeed = 0.8
    }
}


extension FavoritesViewController : CharactersViewOutputDelegate {
    func characterItemCellTap(uiModel: CharactersViewItemCellUIModel) {
        self.showToast(message: "Character : \(uiModel.name)")
        guard let characterId = uiModel.character.id else { return }
        self.viewModel.pushCharacterDetailViewController(characterId: characterId)
    }
    
    func charactersPagination() {
        
    }
    
    
}
