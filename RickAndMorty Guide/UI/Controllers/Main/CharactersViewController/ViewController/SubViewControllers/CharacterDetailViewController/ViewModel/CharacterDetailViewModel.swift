//
//  CharacterDetailViewModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.08.2022.
//

import Bond
import ReactiveKit

protocol ICharacterDetailViewModel: AnyObject {

    var _viewState: ScreenStateSubject<CharacterDetailViewState> { get }
    var _actionState: ScreenStateSubject<CharacterDetailActionState> { get }
    var _errorState: ErrorStateSubject { get }
    var _episodeErrorState: ErrorStateSubject { get }

    init(repository: ICharacterDetailRepository,
         episodeRepository: IEpisodesRepository,
         coordinator: ICharacterDetailCoordinator,
         uiModel: ICharacterDetailUIModel)
    
    func getCharacterDetailService()
    func getCharacterDetail() -> CharacterModel?
    func getCharacterEpisodes() -> [EpisodeModel]?
    func addRemoveFavorite()
    func getCharacterId() -> Int?
}

final class CharacterDetailViewModel: BaseViewModel, ICharacterDetailViewModel {

    // MARK: Definitions
    private let repository: ICharacterDetailRepository
    private let episodeRepository: IEpisodesRepository
    private let coordinator: ICharacterDetailCoordinator
    private var uiModel: ICharacterDetailUIModel

    // MARK: Private Props
    private let viewState = ScreenStateSubject<CharacterDetailViewState>()
    private let actionState = ScreenStateSubject<CharacterDetailActionState>()
    private let errorState = ErrorStateSubject()
    private let episodeErrorState = ErrorStateSubject()

    private let characterDetailResponse = Observable<CharacterModel?>(nil)
    private let multiEpisodesResponse = Observable<[EpisodeModel]?>(nil)
    private let singleEpisodeResponse = Observable<EpisodeModel?>(nil)

    // MARK: Public Props
    var _viewState: ScreenStateSubject<CharacterDetailViewState> { viewState }
    var _actionState: ScreenStateSubject<CharacterDetailActionState> { actionState }
    var _errorState: ErrorStateSubject { errorState }
    var _episodeErrorState: ErrorStateSubject { episodeErrorState }

    // MARK: Initiliazer
    required init(repository: ICharacterDetailRepository,
                  episodeRepository: IEpisodesRepository,
                  coordinator: ICharacterDetailCoordinator,
                  uiModel: ICharacterDetailUIModel) {
        self.repository = repository
        self.episodeRepository = episodeRepository
        self.coordinator = coordinator
        self.uiModel = uiModel
    }

    func getCharacterId() -> Int? {
        return uiModel.getCharacterId()
    }
    
    func getCharacterDetail() -> CharacterModel? {
        guard let character = uiModel.getCharacterDetail() else { return nil }
        
        return character
    }
    
    func getCharacterEpisodes() -> [EpisodeModel]? {
        guard let episodes = uiModel.getCharacterEpisodes() else { return nil }
        
        return episodes
    }
    
    func addRemoveFavorite() {
        guard let characterModel = uiModel.getCharacterDetail() else { return }
        
        var favoriteActionStatus : FavoriteActionStatusEnum = .addFavorite
        
        if let characterId = characterModel.id {
            if UserManager.shared.isCharacterInFavorite(id: characterId) {
                UserManager.shared.removeFavorite(value: characterModel)
                favoriteActionStatus = .removeFavorite
            }else {
                UserManager.shared.addFavorite(value: characterModel)
                favoriteActionStatus = .addFavorite
            }
        }
        
        self.viewStateShowAddFovriteSuccessPopup(favoriteActionStatus: favoriteActionStatus)
        self.viewStateRefreshUI()
    }
}


// MARK: Service
internal extension CharacterDetailViewModel {
    func getCharacterDetailService() {
        
        guard let characterId = uiModel.getCharacterId() else { return }
        let parameters = GetCharacterDetailRequestParameters(id: characterId)
        
        handleResourceToAPIState(
            errorState: self.errorState,
            response: self.characterDetailResponse,
            request: repository.getCharacterDetail(parameters: parameters),
            callbackLoading: { [weak self] isLoading in
                guard let self = self else { return }
                self.viewStateShowProgressLoading(isProgress: isLoading)
            },
            callbackSuccess: { [weak self] in
                guard let self = self else { return }
                self.handleCharacterDetailResponse()
            }
        )
    }
    
    private func getCharacterSingleEpisodeService() {
        if uiModel.getEpisodeIds().isNotEmpty {
            let parameters = GetSomeEpisodesRequestParameters(episodes: uiModel.getEpisodeIds())
            
            handleResourceToAPIState(
                errorState: self.episodeErrorState,
                response: self.singleEpisodeResponse,
                request: episodeRepository.getSingleEpisodes(parameters: parameters),
                callbackLoading: { [weak self] isLoading in
                    guard let self = self else { return }
                    self.viewStateShowProgressLoading(isProgress: isLoading)
                },
                callbackSuccess: { [weak self] in
                    guard let self = self else { return }
                    self.handleEpisodesResponse()
                }
            )
        }
    }
    
    private func getCharacterMultiEpisodesService() {
        if uiModel.getEpisodeIds().isNotEmpty {
            let parameters = GetSomeEpisodesRequestParameters(episodes: uiModel.getEpisodeIds())
            
            handleResourceToAPIState(
                errorState: self.episodeErrorState,
                response: self.multiEpisodesResponse,
                request: episodeRepository.getMultiEpisodes(parameters: parameters),
                callbackLoading: { [weak self] isLoading in
                    guard let self = self else { return }
                    self.viewStateShowProgressLoading(isProgress: isLoading)
                },
                callbackSuccess: { [weak self] in
                    guard let self = self else { return }
                    self.handleEpisodesResponse()
                }
            )
        }
    }
}

//MARK: Handle Response
internal extension CharacterDetailViewModel {
    private func handleCharacterDetailResponse() {
        guard let characterModel = characterDetailResponse.value else { return }
        
        self.uiModel.setCharacterDetailResponse(characterModel: characterModel)
        viewStateRefreshUI()
        
        if let episodes = self.uiModel.getCharacterDetail()?.episode {
            if episodes.count > 1 {
                getCharacterMultiEpisodesService()
            }else {
                getCharacterSingleEpisodeService()
            }
        }
    }
    
    private func handleEpisodesResponse() {
        if let episodes = self.uiModel.getCharacterDetail()?.episode {
            if episodes.count > 1 {
                guard let _episodes = multiEpisodesResponse.value else {
                    viewStateRefreshUI()
                    return
                }
                
                self.uiModel.setEpisodesResponse(episodesModel: _episodes)
                viewStateRefreshUI()
            }else {
                guard let _episode = singleEpisodeResponse.value else {
                    viewStateRefreshUI()
                    return
                }
                
                self.uiModel.setEpisodesResponse(episodesModel: [_episode])
                viewStateRefreshUI()
            }
        }
    }
}

// MARK: States
internal extension CharacterDetailViewModel {

    // MARK: View State
    func viewStateShowProgressLoading(isProgress: Bool) {
        self.viewState.on(.next(.showLoadingProgress(isProgress: isProgress)))
    }

    func viewStateShowToast(message: String) {
        self.viewState.on(.next(.showToast(message: message)))
    }
    
    func viewStateRefreshUI() {
        self.viewState.on(.next(.refreshUI))
    }
    
    func viewStateShowAddFovriteSuccessPopup(favoriteActionStatus: FavoriteActionStatusEnum) {
        self.viewState.on(.next(.showFavoriteActionSuccessPopup(favoriteActionStatus: favoriteActionStatus)))
    }
    
    // MARK: Action State

}

// MARK: Coordinate
internal extension CharacterDetailViewModel {

}


enum CharacterDetailViewState {
    case showLoadingProgress(isProgress: Bool)
    case showToast(message: String)
    case refreshUI
    case showFavoriteActionSuccessPopup(favoriteActionStatus: FavoriteActionStatusEnum)
}

enum CharacterDetailActionState {

}


