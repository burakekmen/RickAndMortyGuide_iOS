//
//  BaseReusableView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit

open class BaseReusableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSelf()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSelf()
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initializeSelf()
    }

    internal func initializeSelf() {
        preconditionFailure("initializeSelf - This method must be overridden")
    }
}


class HighlightBaseReusableView :BaseReusableView {
    
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
