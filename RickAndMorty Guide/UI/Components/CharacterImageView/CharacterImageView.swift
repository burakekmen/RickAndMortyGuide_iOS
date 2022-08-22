//
//  CharacterImageView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.08.2022.
//

import Foundation
import UIKit
import Kingfisher

protocol CharacterImageViewOutputDelegate : AnyObject {
    
}

class CharacterImageView : UIView, CustomViewProtocol {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var contentViewDetail: UIView!
    weak var delegate : CharacterImageViewOutputDelegate?
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblCharacterName: UILabel!
    
    @IBOutlet weak var characterNameViewHeightConstraint: NSLayoutConstraint!
    
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
        
        if let imageUrl = characterModel?.image, imageUrl.isValidURL {
            imgCharacter.alpha = 0
            imgCharacter.kf.setImage(with: URL(string: imageUrl))
            
            UIView.animate(withDuration: 0.2, animations: {
                self.imgCharacter.alpha = 1
            })
        }
        
        if let characterName = characterModel?.name {
            lblCharacterName.text = characterName
            characterNameViewHeightConstraint.constant = heightForView(text: characterName, font: UIFont.fontRickAndMorty(size: 25), width: UIScreen.main.bounds.width - 40) + 20
        }else {
            characterNameViewHeightConstraint.constant = 0
        }
        
        contentViewDetail.roundCornersEachCorner(.allCorners, radius: 10)
        contentView.setDefaultShadow()
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
