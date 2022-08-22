//
//  CharactersViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 23.05.2022.
//

import UIKit
import ReactiveKit
import Bond

final class CharactersViewController: MainBaseViewController {

    // MARK: Constants

    override var isShowTabbar: Bool {
        return true
    }
    
    var currentStatusFilterIndex = 0

    // MARK: Inject
    private let viewModel: ICharactersViewModel

    // MARK: IBOutlets
    @IBOutlet weak var charactersView: CharactersView!
    @IBOutlet weak var searchAndFilterView: SearchBarView!
    
    // MARK: Constraints Outlets
    
    // MARK: Initializer
    init(viewModel: ICharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CharactersViewController", bundle: nil)
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

    override func setupView() {
        self.setupCharactersView()
    }
    
    override func initialComponents() {
        self.observeReactiveDatas()
        self.viewModel.getAllCharactersService(nil, nil)
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
            case .reloadTableView(let isPaginating):
                self.charactersView.isPaginating = isPaginating
                self.charactersView.characters = viewModel.getCharactersData()
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
        observeErrorState(errorState: viewModel._errorState)
    }

    // MARK: Define Components (if you have or delete this line)
    private func setupCharactersView() {
        self.charactersView.outputDelegate = self
        self.searchAndFilterView.delegate = self
        self.searchAndFilterView.filterPickerView.filterValues = viewModel.getFilterValuesForPicker()
        self.searchAndFilterView.filterPickerView.txtPickerFilterType.text = viewModel.getFilterValueWithIndex(index: 0)
        self.searchAndFilterView.filterPickerView.txtPickerFilterType.textAlignment = .left
    }
}

// MARK: Props
private extension CharactersViewController {
    
}

// MARK: CharactersViewOutputDelegate
extension CharactersViewController : CharactersViewOutputDelegate {
    func charactersPagination() {
        self.viewModel.searchCharactersPagination()
    }
    
    func characterItemCellTap(uiModel: CharactersViewItemCellUIModel) {
        guard let characterId = uiModel.character.id else { return }
        self.viewModel.pushCharacterDetailViewController(characterId: characterId)
    }
}

// MARK: SearchBarViewOutputDelegate
extension CharactersViewController : SearchBarViewOutputDelegate {
    func searchbarDidEditing(searchValue: String?) {
        self.searchAndFilterView.filterPickerView.txtPickerFilterType.text = self.viewModel.getFilterValueWithIndex(index: 0)
        self.searchAndFilterView.filterPickerView.pickerView.selectRow(0, inComponent: 0, animated: false)
        
        self.viewModel.resetPagination()
        self.viewModel.getAllCharactersService(nil, searchValue)
    }
    
    func filterPickerDidSelect(index: Int) {
        self.currentStatusFilterIndex = index
        
        self.searchAndFilterView.searchBar.text = nil
        let filterValue = viewModel.getFilterValueWithIndex(index: index)
        
        self.viewModel.resetPagination()
        self.viewModel.getAllCharactersService(filterValue, nil)
    }
}
