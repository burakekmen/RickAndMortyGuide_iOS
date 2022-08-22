//
//  CharactersView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.06.2022.
//

import UIKit

protocol CharactersViewOutputDelegate: AnyObject {
    func characterItemCellTap(uiModel: CharactersViewItemCellUIModel)
    func charactersPagination()
}

class CharactersView: BaseReusableNibView {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Props
    weak var outputDelegate: CharactersViewOutputDelegate?
    private var cellUIModels: [CharactersViewItemCellUIModel] = []
    
    // MARK: BURAK - sadece favori ekranında silme islemi yapılabilmesi icin
    var canEditableTable : Bool = false
    var isPaginating : Bool = false
    
    var characters : [CharacterModel] = [] {
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
private extension CharactersView {
    func initTableView() {
        self.tableView.registerCell(CharactersViewItemCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.autoresizingMask = [.flexibleHeight]
        tableView.removeTableHeaderView()
        tableView.removeTableFooterView()
    }
    
    func mappedToCellUIModels() {
        self.cellUIModels = characters.compactMap { CharactersViewItemCellUIModel(character: $0) }
    }
    
    func getCellUIModel(at index: Int) -> CharactersViewItemCellUIModel {
        return cellUIModels[index]
    }
    
    func refreshList() {
        if !isPaginating {
            tableView.scrollToTop(animated: true)
        }
        
        tableView.reloadData()
    }
}


// MARK: UITableViewDelegate & UITableViewDataSource
extension CharactersView: UITableViewDelegate, UITableViewDataSource, CharactersViewItemCellCellOutputDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.generateReusableCell(CharactersViewItemCell.self, indexPath: indexPath)
        
        cell.outputDelegate = self
        cell.configureCell(with: self.getCellUIModel(at: indexPath.row))
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharactersViewItemCell.defaultHeight 
    }
    
    func charactersViewItemCellTap(uiModel: CharactersViewItemCellUIModel) {
        self.outputDelegate?.characterItemCellTap(uiModel: uiModel)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isAvailablePagination {
            self.outputDelegate?.charactersPagination()
        }
    }
}
