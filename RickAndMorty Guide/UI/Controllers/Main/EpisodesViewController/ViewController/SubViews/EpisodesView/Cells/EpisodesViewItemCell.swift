//
//  EpisodesViewItemCell.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 29.06.2022.
//

import UIKit

protocol EpisodesViewItemCellOutputDelegate: AnyObject {
    func episodesViewItemCellTap(uiModel: EpisodesViewItemCellUIModel)
}

class EpisodesViewItemCell: BaseTableViewCell {

    // MARK: Outlets
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblEpisodeName: UILabel!
    @IBOutlet weak var lblEpisodePart: UILabel!
    @IBOutlet weak var lblEpisodeAirDate: UILabel!
    
    // MARK: Definitions
    weak var outputDelegate: EpisodesViewItemCellOutputDelegate? = nil
    
    static let cellWidth: CGFloat = UIScreen.main.bounds.width
    static let cellHeight: CGFloat = cellWidth / 3.2
    

    func configureCell(with uiModel: EpisodesViewItemCellUIModel) {

        lblEpisodeName.text = uiModel.episodeName
        lblEpisodePart.text = uiModel.episodePart
        lblEpisodeAirDate.text = uiModel.episodeAirDate
        
        lblEpisodeName.font = .fontSFProText(type: .Regular, size: 20)
        lblEpisodePart.font = .fontSFProText(type: .Regular, size: 13)
        lblEpisodeAirDate.font = .fontSFProText(type: .Regular, size: 15)
        
        subView.roundCornersEachCorner(.allCorners, radius: 10)
        subView.setDefaultShadow()
        
        // Events
        registerEvents(uiModel: uiModel)
    }

    private func registerEvents(uiModel: EpisodesViewItemCellUIModel) {
        subView.onTap { [unowned self] _ in
            self.outputDelegate?.episodesViewItemCellTap(uiModel: uiModel)
        }
    }
    
    override class var defaultHeight: CGFloat {
        return cellHeight
    }
}
