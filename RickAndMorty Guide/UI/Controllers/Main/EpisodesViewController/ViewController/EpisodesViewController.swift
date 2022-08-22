//
//  EpisodesViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 26.05.2022.
//

import UIKit
import ReactiveKit
import Bond

final class EpisodesViewController: MainBaseViewController {

    // MARK: Constants

    override var isShowTabbar: Bool {
        return true
    }

    // MARK: Inject
    private let viewModel: IEpisodesViewModel

    // MARK: IBOutlets
    @IBOutlet weak var episodesView: EpisodesView!
    @IBOutlet weak var txtSeasonPicker: TextFieldPickerView!
    
    // MARK: Constraints Outlets
    
    // MARK: Initializer
    init(viewModel: IEpisodesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "EpisodesViewController", bundle: nil)
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
        self.setupEpisodesView()
        self.txtSeasonPicker.filterValues = viewModel.getSeasonValuesForPicker()
        self.txtSeasonPicker.txtPickerFilterType.text = viewModel.getSeasonValueWithIndex(index: 0)
        self.txtSeasonPicker.delegate = self
    }
    
    override func initialComponents() {
        self.observeReactiveDatas()
        self.viewModel.getAllEpisodesService(nil)
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
            case .reloadTableView:
                self.episodesView.episodes = viewModel.getEpisodesData()
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
    private func setupEpisodesView() {
        self.episodesView.outputDelegate = self
    }
}

// MARK: Props
private extension EpisodesViewController {
    
}

// MARK: CharactersViewOutputDelegate
extension EpisodesViewController : EpisodesViewOutputDelegate {
    func episodesViewCellTap(uiModel: EpisodesViewItemCellUIModel) {
        guard let episodeId = uiModel.episodeId else { return }
        self.viewModel.pushEpisodeDetailViewController(episodeId: episodeId)
    }
}


extension EpisodesViewController : TextFieldPickerViewOutputDelegate {
    func filterPickerDidSelect(index: Int) {
        self.viewModel.getAllEpisodesService(index)
    }
}
