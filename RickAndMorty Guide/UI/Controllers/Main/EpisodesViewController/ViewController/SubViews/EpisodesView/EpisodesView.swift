//
//  EpisodesView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 29.06.2022.
//

import UIKit

protocol EpisodesViewOutputDelegate: AnyObject {
    func episodesViewCellTap(uiModel: EpisodesViewItemCellUIModel)
}

class EpisodesView: BaseReusableNibView {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Props
    weak var outputDelegate: EpisodesViewOutputDelegate?
    private var cellUIModels: [EpisodesViewItemCellUIModel] = []
    var episodes : [EpisodeModel] = [] {
        didSet {
            mappedToCellUIModels()
            tableView.backgroundColor = .clearColor
            refreshList()
        }
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override func initializeSelf() {
        initTableView()
    }
}

// MARK: Setup
private extension EpisodesView {
    func initTableView() {
        self.tableView.registerCell(EpisodesViewItemCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.autoresizingMask = [.flexibleHeight]
        tableView.removeTableHeaderView()
        tableView.removeTableFooterView()
    }
    
    func mappedToCellUIModels() {
        self.cellUIModels = episodes.compactMap { EpisodesViewItemCellUIModel(episode: $0) }
    }
    
    func getCellUIModel(at index: Int) -> EpisodesViewItemCellUIModel {
        return cellUIModels[index]
    }
    
    func refreshList() {
        tableView.scrollToTop(animated: true)
        tableView.reloadData()
        
    }
}


// MARK: UITableViewDelegate & UITableViewDataSource
extension EpisodesView: UITableViewDelegate, UITableViewDataSource, EpisodesViewItemCellOutputDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.generateReusableCell(EpisodesViewItemCell.self, indexPath: indexPath)
        
        cell.outputDelegate = self
        cell.configureCell(with: self.getCellUIModel(at: indexPath.row))
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EpisodesViewItemCell.defaultHeight
    }
    
    func episodesViewItemCellTap(uiModel: EpisodesViewItemCellUIModel) {
        self.outputDelegate?.episodesViewCellTap(uiModel: uiModel)
    }
}
