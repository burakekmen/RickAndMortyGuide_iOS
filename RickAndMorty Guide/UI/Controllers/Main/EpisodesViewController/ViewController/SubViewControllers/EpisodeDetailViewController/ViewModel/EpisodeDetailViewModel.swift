//
//  EpisodeDetailViewModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 11.08.2022.
//

import Bond
import ReactiveKit

protocol IEpisodeDetailViewModel: AnyObject {

    var _viewState: ScreenStateSubject<EpisodeDetailViewState> { get }
    var _actionState: ScreenStateSubject<EpisodeDetailActionState> { get }
    var _errorState: ErrorStateSubject { get }

    init(repository: IEpisodeDetailRepository,
         characterRepository: ICharactersRepository,
         coordinator: IEpisodeDetailCoordinator,
         uiModel: IEpisodeDetailUIModel)
    
    func getEpisodeDetailService()
    
    func getEpisodeDetail() -> EpisodeModel?
    func getEpisodeCharacters() -> [CharacterModel]?
    
    // Coordinate
    func pushCharacterDetailViewController(characterId: Int)
}

final class EpisodeDetailViewModel: BaseViewModel, IEpisodeDetailViewModel {

    // MARK: Definitions
    private let repository: IEpisodeDetailRepository
    private let characterRepository: ICharactersRepository
    private let coordinator: IEpisodeDetailCoordinator
    private var uiModel: IEpisodeDetailUIModel

    // MARK: Private Props
    private let viewState = ScreenStateSubject<EpisodeDetailViewState>()
    private let actionState = ScreenStateSubject<EpisodeDetailActionState>()
    private let errorState = ErrorStateSubject()
    
    private let episodeDetailResponse = Observable<EpisodeModel?>(nil)
    private let episodeCharactersResponse = Observable<[CharacterModel]?>(nil)

    // MARK: Public Props
    var _viewState: ScreenStateSubject<EpisodeDetailViewState> { viewState }
    var _actionState: ScreenStateSubject<EpisodeDetailActionState> { actionState }
    var _errorState: ErrorStateSubject { errorState }

    // MARK: Initiliazer
    required init(repository: IEpisodeDetailRepository,
                  characterRepository: ICharactersRepository,
                  coordinator: IEpisodeDetailCoordinator,
                  uiModel: IEpisodeDetailUIModel) {
        self.repository = repository
        self.characterRepository = characterRepository
        self.coordinator = coordinator
        self.uiModel = uiModel
    }

    func getEpisodeDetail() -> EpisodeModel? {
        return uiModel.getEpisodeDetail()
    }
    
    func getEpisodeCharacters() -> [CharacterModel]? {
        return uiModel.getEpisodeCharacters()
    }
}


// MARK: Service
internal extension EpisodeDetailViewModel {
    func getEpisodeDetailService() {
        
        guard let episodeId = uiModel.getEpisodeId() else { return }
        let parameters = GetEpisodeDetailRequestParameters(episodeId: episodeId)
        
        handleResourceToAPIState(
            errorState: self.errorState,
            response: self.episodeDetailResponse,
            request: repository.getEpisodeDetail(parameters: parameters),
            callbackLoading: { [weak self] isLoading in
                guard let self = self else { return }
                self.viewStateShowProgressLoading(isProgress: isLoading)
            },
            callbackComplete: { [weak self] in
                guard let self = self else { return }
                self.handleEpisodeDetailResponse()
            }
        )
    }
    
    func getEpisodeCharactersService() {
        
        guard let characterIds = uiModel.getCharactersIds(), characterIds.isNotEmpty else { return }
        let parameters = GetSomeCharactersRequestParameters(characters: characterIds)
        
        handleResourceToAPIState(
            errorState: self.errorState,
            response: self.episodeCharactersResponse,
            request: characterRepository.getSomeCharacters(parameters: parameters),
            callbackLoading: { [weak self] isLoading in
                guard let self = self else { return }
                self.viewStateShowProgressLoading(isProgress: isLoading)
            },
            callbackComplete: { [weak self] in
                guard let self = self else { return }
                self.handleEpisodeCharactersResponse()
            }
        )
    }
}

//MARK: Handle Response
internal extension EpisodeDetailViewModel {
    private func handleEpisodeDetailResponse() {
        guard let episodeResponse = episodeDetailResponse.value else { return }
        
        self.uiModel.setEpisodeDetailResponse(episodeModel: episodeResponse)
        
        viewStateRefreshUI()
        
        if let characters = uiModel.getCharactersIds(), characters.isNotEmpty {
            getEpisodeCharactersService()
        }
    }
    
    private func handleEpisodeCharactersResponse() {
        guard let episodeCharacters = episodeCharactersResponse.value else { return }
        
        self.uiModel.setCharactersResponse(charactersModel: episodeCharacters)
        
        viewStateRefreshUI()
    }
}


// MARK: States
internal extension EpisodeDetailViewModel {

    // MARK: View State
    func viewStateShowProgressLoading(isProgress: Bool) {
        self.viewState.on(.next(.showLoadingProgress(isProgress: isProgress)))
    }
    
    func viewStateRefreshUI() {
        self.viewState.on(.next(.refreshUI))
    }

    // MARK: Action State

}

// MARK: Coordinate
internal extension EpisodeDetailViewModel {
    func pushCharacterDetailViewController(characterId: Int) {
        let data = CharacterDetailPassData(characterId: characterId)
        self.coordinator.pushCharacterDetailViewController(with: data)
    }
}


enum EpisodeDetailViewState {
    case showLoadingProgress(isProgress: Bool)
    case refreshUI
}

enum EpisodeDetailActionState {

}


