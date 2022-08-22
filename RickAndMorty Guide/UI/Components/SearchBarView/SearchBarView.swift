//
//  SearchBarView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 28.07.2022.
//

import Foundation
import UIKit

protocol SearchBarViewOutputDelegate : AnyObject {
    func filterPickerDidSelect(index: Int)
    func searchbarDidEditing(searchValue: String?)
}

class SearchBarView : UIView, CustomViewProtocol {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterPickerView: TextFieldPickerView!
    weak var delegate : SearchBarViewOutputDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        self.commonInit(for: nibName())
        
        filterPickerView.delegate = self
        searchBar.delegate = self
        
        setupSearchBar()
    }

}


extension SearchBarView {
    private func setupSearchBar() {
        self.searchBar.barTintColor = .primaryLightGray
        self.searchBar.layer.borderWidth = 1
        self.searchBar.layer.borderColor = UIColor.primaryLightGray.cgColor
    }
}


extension SearchBarView : TextFieldPickerViewOutputDelegate {
    func filterPickerDidSelect(index: Int) {
        delegate?.filterPickerDidSelect(index: index)
    }
}


extension SearchBarView : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.hideKeyboard()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.delegate?.searchbarDidEditing(searchValue: searchBar.text)
    }
}
