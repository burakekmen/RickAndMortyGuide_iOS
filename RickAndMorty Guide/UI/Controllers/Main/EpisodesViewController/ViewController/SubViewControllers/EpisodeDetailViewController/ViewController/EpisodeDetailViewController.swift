//
//  EpisodeDetailViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 11.08.2022.
//

import UIKit
import ReactiveKit
import Bond

final class EpisodeDetailViewController: MainBaseViewController {

    // MARK: Constants
    override var navigationTitleKey: GeneralLocalizeKeys? {
        return .str_episode_detail_page_navigation_title
    }

    // MARK: Inject
    private let viewModel: IEpisodeDetailViewModel

    // MARK: IBOutlets
    @IBOutlet weak var lblEpisodeName: UILabel!
    @IBOutlet weak var lblEpisodePart: UILabel!
    @IBOutlet weak var charactersCollectionView: CharactersCollectionView!
    
    // MARK: Constraints Outlets
    @IBOutlet weak var charactersCollectionViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: Initializer
    init(viewModel: IEpisodeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "EpisodeDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func initialComponents() {
        self.observeReactiveDatas()
        
        self.viewModel.getEpisodeDetailService()
    }

    override func setupView() {
        setupCharactersView()
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
            case .refreshUI:
                self.refreshUI()
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
private extension EpisodeDetailViewController {
    private func setupCharactersView() {
        self.charactersCollectionView.outputDelegate = self
    }
    
    private func refreshUI() {
        guard let episodeDetail = self.viewModel.getEpisodeDetail() else { return }
        
        if let episodeName = episodeDetail.name {
            self.lblEpisodeName.text = episodeName
        }
        
        if let episodePart = episodeDetail.episode {
            self.lblEpisodePart.text = episodePart
        }
        
        guard let characters = self.viewModel.getEpisodeCharacters() else {
            self.charactersCollectionViewHeightConstraint.constant = 0
            self.charactersCollectionView.alpha = 0
            self.charactersCollectionView.isHidden = true
            return
        }
        
        self.charactersCollectionView.episodeCharacters = characters
        self.charactersCollectionViewHeightConstraint.constant = self.charactersCollectionView.collectionView.contentSize.height
        
        if self.charactersCollectionViewHeightConstraint.constant < 200 {
            self.charactersCollectionViewHeightConstraint.constant = 220
        }
        
        self.charactersCollectionView.collectionView.isScrollEnabled = false
        self.charactersCollectionView.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.charactersCollectionView.alpha = 1
        }
    }
}



extension EpisodeDetailViewController : CharactersCollectionViewOutputDelegate {
    func charactersViewItemCellTap(character: CharacterModel) {
        guard let characterId = character.id else { return }
        self.viewModel.pushCharacterDetailViewController(characterId: characterId)
    }
}
