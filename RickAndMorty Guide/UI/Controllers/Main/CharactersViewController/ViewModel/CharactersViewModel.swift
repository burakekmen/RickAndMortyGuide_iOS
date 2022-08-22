//
//  CharactersViewModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 23.05.2022.
//

import Bond
import ReactiveKit

protocol ICharactersViewModel: AnyObject {

    var _viewState: ScreenStateSubject<CharactersViewState> { get }
    var _actionState: ScreenStateSubject<CharactersActionState> { get }
    var _errorState: ErrorStateSubject { get }

    init(repository: ICharactersRepository,
         coordinator: ICharactersCoordinator,
         uiModel: ICharactersUIModel)
    
    func getAllCharactersService(_ filterValue : String?, _ searchValue: String?)
    func getCharactersData() -> [CharacterModel]
    func getFilterValuesForPicker() -> [String]
    func getFilterValueWithIndex(index: Int) -> String
    func searchCharactersPagination()
    func resetPagination()
    
    // Coordinate
    func pushCharacterDetailViewController(characterId: Int)
}

final class CharactersViewModel: BaseViewModel, ICharactersViewModel {

    // MARK: Definitions
    private let repository: ICharactersRepository
    private let coordinator: ICharactersCoordinator
    private var uiModel: ICharactersUIModel

    // MARK: Private Props
    private let viewState = ScreenStateSubject<CharactersViewState>()
    private let actionState = ScreenStateSubject<CharactersActionState>()
    private let errorState = ErrorStateSubject()
    private let allCharactersResponse = Observable<AllCharactersResponse?>(nil)
    
    private var isPaginating = false
    private let pageSize = 20 // sabit
    private var pageNumber = 1 // artan
    private var currentFilterValue : String?
    private var currentSearchValue : String?

    // MARK: Public Props
    var _viewState: ScreenStateSubject<CharactersViewState> { viewState }
    var _actionState: ScreenStateSubject<CharactersActionState> { actionState }
    var _errorState: ErrorStateSubject { errorState }

    // MARK: Initiliazer
    required init(repository: ICharactersRepository,
                  coordinator: ICharactersCoordinator,
                  uiModel: ICharactersUIModel) {
        self.repository = repository
        self.coordinator = coordinator
        self.uiModel = uiModel
    }

    func getCharactersData() -> [CharacterModel] {
        return uiModel.getCharactersData() ?? []
    }
    
    func getFilterValuesForPicker() -> [String] {
        return uiModel.getFilterValuesArray()
    }
    
    func getFilterValueWithIndex(index: Int) -> String {
        return uiModel.getFilterValueWithIndex(index: index)
    }
}


// MARK: Service
internal extension CharactersViewModel {
    func getAllCharactersService(_ filterValue : String?, _ searchValue: String?) {
        
        var requestSearchFilterParameter: String?
        var requestStatusParameter : String?
        
        if let status = filterValue {
            if status != "All" {
                requestStatusParameter = status
                self.currentFilterValue = status
                self.currentSearchValue = nil
            }else {
                self.resetPagination()
            }
        }
        
        if let search = searchValue {
            requestSearchFilterParameter = search
            self.currentSearchValue = search
            self.currentFilterValue = nil
        }
        
        let parameters = GetAllCharactersRequestParameters(filters: GetAllCharactersFiltersParameters(page: pageNumber, name: requestSearchFilterParameter, status: requestStatusParameter))
        
        handleResourceToAPIState(
            errorState: self.errorState,
            response: self.allCharactersResponse,
            request: repository.getAllCharacters(parameters: parameters),
            callbackLoading: { [weak self] isLoading in
                guard let self = self else { return }
                self.viewStateShowProgressLoading(isProgress: isLoading)
            },
            callbackSuccess: { [weak self] in
                guard let self = self else { return }
                self.handleCharactersResponse()
                self.viewStateReloadTableView(isPagination: self.isPaginating)
                
                self.isPaginating = false
            }
        )
    }
}


//MARK: Handle Response
internal extension CharactersViewModel {
    private func handleCharactersResponse() {
        if isPaginating {
            self.uiModel.setCharactersDataWithPagination(characters: allCharactersResponse.value?.results)
        }else {
            self.uiModel.setCharactersData(characters: allCharactersResponse.value?.results)
        }
    }
}



internal extension CharactersViewModel {
    private func isReachLastPagePagination() -> Bool {
        let maxPage = self.allCharactersResponse.value?.info?.pages ?? 0
        return self.pageNumber >= maxPage
    }

    func resetPagination() {
        self.pageNumber = 1
        self.isPaginating = false
    }
    
    func searchCharactersPagination() {
        if !isPaginating && !self.isReachLastPagePagination() {
            isPaginating = true
            self.pageNumber += 1
            self.getAllCharactersService(self.currentFilterValue, self.currentSearchValue)
        }
    }
}



// MARK: States
internal extension CharactersViewModel {

    // MARK: View State
    func viewStateShowProgressLoading(isProgress: Bool) {
        self.viewState.on(.next(.showLoadingProgress(isProgress: isProgress)))
    }
    
    func viewStateShowToast(message: String) {
        self.viewState.on(.next(.showToast(message: message)))
    }

    func viewStateReloadTableView(isPagination: Bool) {
        self.viewState.on(.next(.reloadTableView(isPagination: isPagination)))
    }
    // MARK: Action State

}

// MARK: Coordinate
internal extension CharactersViewModel {
    func pushCharacterDetailViewController(characterId: Int) {
        let data = CharacterDetailPassData(characterId: characterId)
        self.coordinator.pushCharacterDetailViewController(with: data)
    }
}


enum CharactersViewState {
    case showLoadingProgress(isProgress: Bool)
    case showToast(message: String)
    case reloadTableView(isPagination: Bool)
}

enum CharactersActionState {

}


