//
//  EpisodesViewModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 26.05.2022.
//

import Bond
import ReactiveKit

protocol IEpisodesViewModel: AnyObject {

    var _viewState: ScreenStateSubject<EpisodesViewState> { get }
    var _actionState: ScreenStateSubject<EpisodesActionState> { get }
    var _errorState: ErrorStateSubject { get }

    init(repository: IEpisodesRepository,
         coordinator: IEpisodesCoordinator,
         uiModel: IEpisodesUIModel)
    
    func getAllEpisodesService(_ seasonValue : Int?)
    func getEpisodesData() -> [EpisodeModel]
    func getSeasonValuesForPicker() -> [String]
    func getSeasonValueWithIndex(index: Int) -> String
    
    // Coordinate
    func pushEpisodeDetailViewController(episodeId: Int)
}

final class EpisodesViewModel: BaseViewModel, IEpisodesViewModel {

    // MARK: Definitions
    private let repository: IEpisodesRepository
    private let coordinator: IEpisodesCoordinator
    private var uiModel: IEpisodesUIModel

    // MARK: Private Props
    private let viewState = ScreenStateSubject<EpisodesViewState>()
    private let actionState = ScreenStateSubject<EpisodesActionState>()
    private let errorState = ErrorStateSubject()
    private let allEpisodesResponse = Observable<AllEpisodesResponse?>(nil)

    // MARK: Public Props
    var _viewState: ScreenStateSubject<EpisodesViewState> { viewState }
    var _actionState: ScreenStateSubject<EpisodesActionState> { actionState }
    var _errorState: ErrorStateSubject { errorState }

    // MARK: Initiliazer
    required init(repository: IEpisodesRepository,
                  coordinator: IEpisodesCoordinator,
                  uiModel: IEpisodesUIModel) {
        self.repository = repository
        self.coordinator = coordinator
        self.uiModel = uiModel
    }

    func getEpisodesData() -> [EpisodeModel] {
        return uiModel.getEpisodesData() ?? []
    }
    
    func getSeasonValuesForPicker() -> [String] {
        return uiModel.getSeasonValuesArray()
    }
    
    func getSeasonValueWithIndex(index: Int) -> String {
        return uiModel.getSeasonValueWithIndex(index: index)
    }
}


// MARK: Service
internal extension EpisodesViewModel {
    func getAllEpisodesService(_ seasonValue : Int?) {
        
        var requestSeasonParameter = ""
        if let season = seasonValue {
            requestSeasonParameter = "S0\(season+1)"
        }else {
            requestSeasonParameter = "S01"
        }
        
        let parameters = GetAllEpisodesRequestParameters(filters: GetAllEpisodesFiltersParameters(episode: requestSeasonParameter))
        
        handleResourceToAPIState(
            errorState: self.errorState,
            response: self.allEpisodesResponse,
            request: repository.getAllEpisodes(parameters: parameters),
            callbackLoading: { [weak self] isLoading in
                guard let self = self else { return }
                self.viewStateShowProgressLoading(isProgress: isLoading)
            },
            callbackComplete: { [weak self] in
                guard let self = self else { return }
                self.handleEpisodesResponse()
                self.viewStateReloadTableView()
            }
        )
    }
}


//MARK: Handle Response
internal extension EpisodesViewModel {
    private func handleEpisodesResponse() {
        if let episodes = self.allEpisodesResponse.value?.results {
            self.uiModel.setEpisodesData(episodes: allEpisodesResponse.value?.results)
        }
    }
}

// MARK: States
internal extension EpisodesViewModel {

    // MARK: View State
    func viewStateShowProgressLoading(isProgress: Bool) {
        self.viewState.on(.next(.showLoadingProgress(isProgress: isProgress)))
    }
    
    func viewStateShowToast(message: String) {
        self.viewState.on(.next(.showToast(message: message)))
    }

    func viewStateReloadTableView() {
        self.viewState.on(.next(.reloadTableView))
    }

    // MARK: Action State

}

// MARK: Coordinate
internal extension EpisodesViewModel {
    func pushEpisodeDetailViewController(episodeId: Int) {
        let data = EpisodeDetailPassData(episodeId: episodeId)
        self.coordinator.pushEpisodeDetailViewController(with: data)
    }
}


enum EpisodesViewState {
    case showLoadingProgress(isProgress: Bool)
    case showToast(message: String)
    case reloadTableView
}

enum EpisodesActionState {

}


