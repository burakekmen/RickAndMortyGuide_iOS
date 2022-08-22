//
//  FavoritesViewModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 2.08.2022.
//

import Bond
import ReactiveKit

protocol IFavoritesViewModel: AnyObject {

    var _viewState: ScreenStateSubject<FavoritesViewState> { get }
    var _actionState: ScreenStateSubject<FavoritesActionState> { get }

    init(repository: IFavoritesRepository,
         coordinator: IFavoritesCoordinator,
         uiModel: IFavoritesUIModel)
    
    func reloadFavoriteTableView()
    
    // Coordinates
    func pushCharacterDetailViewController(characterId: Int)
}

final class FavoritesViewModel: BaseViewModel, IFavoritesViewModel {
   
    // MARK: Definitions
    private let repository: IFavoritesRepository
    private let coordinator: IFavoritesCoordinator
    private var uiModel: IFavoritesUIModel

    // MARK: Private Props
    private let viewState = ScreenStateSubject<FavoritesViewState>()
    private let actionState = ScreenStateSubject<FavoritesActionState>()

    // MARK: Public Props
    var _viewState: ScreenStateSubject<FavoritesViewState> { viewState }
    var _actionState: ScreenStateSubject<FavoritesActionState> { actionState }

    // MARK: Initiliazer
    required init(repository: IFavoritesRepository,
                  coordinator: IFavoritesCoordinator,
                  uiModel: IFavoritesUIModel) {
        self.repository = repository
        self.coordinator = coordinator
        self.uiModel = uiModel
    }

    func reloadFavoriteTableView() {
        self.viewStateReloadTableView()
    }
}


// MARK: Service
internal extension FavoritesViewModel {

}

// MARK: States
internal extension FavoritesViewModel {

    // MARK: View State
    func viewStateShowProgressLoading(isProgress: Bool) {
        self.viewState.on(.next(.showLoadingProgress(isProgress: isProgress)))
    }
    
    func viewStateReloadTableView() {
        self.viewState.on(.next(.reloadTableView))
    }

    // MARK: Action State

}

// MARK: Coordinate
internal extension FavoritesViewModel {
    func pushCharacterDetailViewController(characterId: Int) {
        let data = CharacterDetailPassData(characterId: characterId)
        self.coordinator.pushCharacterDetailViewController(with: data)
    }
}


enum FavoritesViewState {
    case showLoadingProgress(isProgress: Bool)
    case reloadTableView
}

enum FavoritesActionState {

}


