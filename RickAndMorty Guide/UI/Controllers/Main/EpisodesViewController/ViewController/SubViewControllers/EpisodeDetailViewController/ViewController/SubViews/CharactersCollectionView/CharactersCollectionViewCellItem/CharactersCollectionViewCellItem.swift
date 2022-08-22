//
//  CharactersCollectionViewCellItem.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 12.08.2022.
//

import UIKit
import Kingfisher

protocol CharactersCollectionViewCellItemOutputDelegate: AnyObject {
    func charactersViewItemCellTap(character: CharacterModel)
}

class CharactersCollectionViewCellItem: UICollectionViewCell, Reuseable {

    // MARK: Outlets
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblCharacterName: UILabel!
    
    // MARK: Definitions
    weak var outputDelegate: CharactersCollectionViewCellItemOutputDelegate? = nil
    
    @IBOutlet weak var characterNameHeightConstraint: NSLayoutConstraint!
    var characterModel: CharacterModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        guard let data = characterModel else {
            return
        }
        
        if let imageUrl = data.image, imageUrl.isValidURL {
            imgCharacter.alpha = 0
            imgCharacter.kf.setImage(with: URL(string: imageUrl))
            
            UIView.animate(withDuration: 0.2, animations: {
                self.imgCharacter.alpha = 1
            })
        }
        
        if let characterName = characterModel?.name {
            lblCharacterName.text = characterName
            characterNameHeightConstraint.constant = heightForView(text: characterName, font: UIFont.fontRickAndMorty(size: 15), width: holderView.width - 20) + 20
        }else {
            characterNameHeightConstraint.constant = 0
        }
        
        subView.roundCornersEachCorner(.allCorners, radius: 10)
        
        self.holderView.onTap { [unowned self] _ in
            self.outputDelegate?.charactersViewItemCellTap(character: data)
        }
    }
}


extension CharactersCollectionViewCellItem {
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
