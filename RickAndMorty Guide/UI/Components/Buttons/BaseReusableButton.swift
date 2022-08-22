//
//  BaseReusableButton.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit

open class BaseReusableButton: UIButton {

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


