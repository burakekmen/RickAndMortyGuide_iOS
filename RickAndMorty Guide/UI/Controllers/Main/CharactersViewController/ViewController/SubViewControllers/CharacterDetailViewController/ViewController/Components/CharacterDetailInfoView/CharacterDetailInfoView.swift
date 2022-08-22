//
//  CharacterDetailInfoView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 10.08.2022.
//

import Foundation
import UIKit

class CharacterDetailInfoView : UIView, CustomViewProtocol {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSpecies: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblLastLocation: UILabel!
    
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    
    var characterModel: CharacterModel? {
        didSet{
            refreshScreen()
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
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    private func refreshScreen() {
        
        guard let character = characterModel else {
            self.infoViewHeightConstraint.constant = 0
            
            return
        }

        lblStatus.text = character.statusFormatted.desc.uppercased()
        lblSpecies.text = character.species?.uppercased()
        lblGender.text = character.gender?.uppercased()
        lblOrigin.text = character.origin?.name?.uppercased()
        lblLastLocation.text = character.location?.name?.uppercased()
        
        lblSpecies.textColor = .characterCellDefaultColor
        lblGender.textColor = .characterCellDefaultColor
        lblOrigin.textColor = .characterCellDefaultColor
        lblLastLocation.textColor = .characterCellDefaultColor
        
        switch character.statusFormatted {
        case .alive:
            lblStatus.textColor = .characterCellAliveStatusColor
        case .dead:
            lblStatus.textColor = .characterCellDeadStatusColor
        case .unknown:
            lblStatus.textColor = .characterCellDefaultColor
        }
        
        
    }
}


extension CharacterImageView {
    private func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
       label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
       label.font = font
       label.text = text

       label.sizeToFit()
       return label.frame.height
   }
}
