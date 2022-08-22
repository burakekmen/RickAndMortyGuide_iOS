//
//  HighlightTableViewCell.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 21.05.2022.
//

import UIKit

class HighlightTableViewCell: BaseTableViewCell {
    
    // for highlight
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animatedAlpha(from: 1.0, to: 0.6)
    }

    // for highlight
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animatedAlpha(from: 0.6, to: 1.0)
    }

    // for highlight
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animatedAlpha(from: 0.6, to: 1.0)
    }
}

