//
//  UIButton+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UIButton {

    func addClickAction(_ target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }

    func setTitleAllState(_ title: String?) {
        setTitle(title, for: .highlighted)
        setTitle(title, for: .normal)
        setTitle(title, for: .selected)
        setTitle(title, for: .disabled)
        setTitle(title, for: .focused)
        setTitle(title, for: .reserved)
        setTitle(title, for: .application)
    }

    func setTitleColorAllState(_ titleColor: UIColor) {
        setTitleColor(titleColor, for: .highlighted)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor, for: .selected)
    }

    func setFont(font: UIFont) {
        self.titleLabel?.font = font
    }
}
