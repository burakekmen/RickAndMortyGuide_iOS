//
//  CharactersViewItemCell.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.06.2022.
//

import UIKit
import Kingfisher

protocol CharactersViewItemCellCellOutputDelegate: AnyObject {
    func charactersViewItemCellTap(uiModel: CharactersViewItemCellUIModel)
}

class CharactersViewItemCell: BaseTableViewCell {

    // MARK: Definitions
    weak var outputDelegate: CharactersViewItemCellCellOutputDelegate? = nil
    
    static let cellWidth: CGFloat = UIScreen.main.bounds.width
    static let cellHeight: CGFloat = cellWidth / 2
    
    // MARK: Outlets
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSpecies: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!

    func configureCell(with uiModel: CharactersViewItemCellUIModel) {
        if uiModel.imageUrl.isNotEmpty && uiModel.imageUrl.isValidURL {
            imgCharacter.alpha = 0
            imgCharacter.roundCornersEachCorner(.allCorners, radius: 10)
            imgCharacter.kf.setImage(with: URL(string: uiModel.imageUrl))
            
            UIView.animate(withDuration: 0.2, animations: {
                self.imgCharacter.alpha = 1
            })
        }
        
        lblName.text = uiModel.name.uppercased()
        lblStatus.text = uiModel.status.desc.uppercased()
        
        lblSpecies.text = uiModel.species.uppercased()
        lblGender.text = uiModel.gender.uppercased()
        lblOrigin.text = uiModel.origin.uppercased()
        
        subView.backgroundColor = .whiteColor
        subView.roundCornersEachCorner(.allCorners, radius: 10)
        subView.setDefaultShadow()
        
        switch uiModel.status {
        case .alive:
            lblStatus.textColor = .characterCellAliveStatusColor
        case .dead:
            lblStatus.textColor = .characterCellDeadStatusColor
        case .unknown:
            lblStatus.textColor = .characterCellDefaultColor
        }
        
        self.contentView.onTap { [unowned self] _ in
            self.outputDelegate?.charactersViewItemCellTap(uiModel: uiModel)
        }
    }
    
    override class var defaultHeight: CGFloat {
        return cellHeight
    }
}
