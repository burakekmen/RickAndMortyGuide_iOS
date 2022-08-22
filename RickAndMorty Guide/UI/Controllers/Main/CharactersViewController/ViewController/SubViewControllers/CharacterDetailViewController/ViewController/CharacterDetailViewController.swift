//
//  CharacterDetailViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.08.2022.
//

import UIKit
import ReactiveKit
import Bond

final class CharacterDetailViewController: MainBaseViewController {

    // MARK: Constants
    override var navigationTitleKey: GeneralLocalizeKeys? {
        return .str_character_detail_page_navigation_title
    }
    
    // MARK: Inject
    private let viewModel: ICharacterDetailViewModel

    // MARK: IBOutlets
    @IBOutlet weak var characterImageView: CharacterImageView!
    @IBOutlet weak var characterDetailInfoView: CharacterDetailInfoView!
    @IBOutlet weak var episodesView: EpisodesView!
    
    @IBOutlet weak var episodeViewHeightConstraint: NSLayoutConstraint!
    // MARK: Constraints Outlets
    
    // MARK: Initializer
    init(viewModel: ICharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CharacterDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.checkCharacterFavorite()
    }

    override func initialComponents() {
        self.observeReactiveDatas()
        self.viewModel.getCharacterDetailService()
    }

    override func registerEvents() {

    }

    private func observeReactiveDatas() {
        observeViewState()
        observeActionState()
        listenErrorState()
    }

    private func observeViewState() {
        viewModel._viewState.observeNext { [unowned self] state in
            switch state {
            case .showLoadingProgress(let isProgress):
                self.playLottieLoading(isLoading: isProgress)
            case .showToast(let message):
                self.showToast(message: message)
            case .refreshUI:
                self.refreshUI()
                self.checkCharacterFavorite()
            case .showFavoriteActionSuccessPopup(favoriteActionStatus: let favoriteActionStatus):
                switch favoriteActionStatus {
                case .addFavorite:
                    self.showToast(message: "Wubba Lubba Dub Dub!")
                case .removeFavorite:
                    self.showToast(message: "I'm Alive I Tell You!")
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
        observeErrorState(errorState: viewModel._errorState,
                          allTypeErrorAlertAction: { [weak self] in
            guard let self = self else { return }
            
            self.selfPopViewController()
        })
    }

    // MARK: Define Components (if you have or delete this line)
}

// MARK: Props
private extension CharacterDetailViewController {
    private func refreshUI() {
        guard let characterModel = self.viewModel.getCharacterDetail() else { return }
        
        self.characterDetailInfoView.characterModel = characterModel
        self.characterImageView.characterModel = characterModel
        self.characterImageView.isHidden = false
        
        guard let episodes = self.viewModel.getCharacterEpisodes() else {
            self.episodeViewHeightConstraint.constant = 0
            self.episodesView.alpha = 0
            self.episodesView.isHidden = true
            return
        }
        
        self.episodesView.episodes = episodes
        self.episodeViewHeightConstraint.constant = (EpisodesViewItemCell.defaultHeight * CGFloat(episodes.count)) + 40
        self.episodesView.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.episodesView.alpha = 1
        }
    }
    
    private func checkCharacterFavorite() {
        guard let characterId = self.viewModel.getCharacterId() else { return }
        
        var isInFavorite : Bool = false
        var favoriteIcon : UIImage = .emptyFavorite
        
        if UserManager.shared.isCharacterInFavorite(id: characterId) {
            favoriteIcon = .fillFavorite
            isInFavorite = true
        }else {
            favoriteIcon = .emptyFavorite
            isInFavorite = false
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: favoriteIcon) { [unowned self] _ in
            self.viewModel.addRemoveFavorite()
        }
    }
    
}
