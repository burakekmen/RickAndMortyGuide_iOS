//
//  CharactersCollectionView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 11.08.2022.
//

import Foundation
import UIKit

protocol CharactersCollectionViewOutputDelegate : AnyObject {
    func charactersViewItemCellTap(character: CharacterModel)
}

class CharactersCollectionView : UIView, CustomViewProtocol {

    @IBOutlet var contentView: UIView!
    weak var outputDelegate : CharactersCollectionViewOutputDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let MARGIN: CGFloat = 15
    let ITEM_GAP: CGFloat = 10
    let NUMBER_OF_ITEMS_IN_A_LINE: CGFloat = 2
    
    var cellWidth: CGFloat = 0
    
    var episodeCharacters: [CharacterModel]? {
        didSet{
            collectionView.reloadData()
            
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
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
        
        setupUI()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension CharactersCollectionView {
    func setupUI() {
        collectionView.registerCell(type: CharactersCollectionViewCellItem.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension CharactersCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeCharacters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharactersCollectionViewCellItem = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.characterModel = episodeCharacters?[indexPath.item]
        cell.outputDelegate = self
        
        return cell
    }
}

extension CharactersCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: MARGIN, bottom: 0, right: MARGIN)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - (2 * MARGIN) - (CGFloat(NUMBER_OF_ITEMS_IN_A_LINE - 1) * ITEM_GAP)) / CGFloat(NUMBER_OF_ITEMS_IN_A_LINE)
        self.cellWidth = width
        
        return CGSize(width: width, height: width)
    }
}


extension CharactersCollectionView : CharactersCollectionViewCellItemOutputDelegate {
    func charactersViewItemCellTap(character: CharacterModel) {
        self.outputDelegate?.charactersViewItemCellTap(character: character)
    }
}
