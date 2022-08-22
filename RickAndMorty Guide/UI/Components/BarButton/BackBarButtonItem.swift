//
//  BackBarButtonItem.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 21.05.2022.
//

import UIKit

class BackBarButtonItem: UIBarButtonItem {

    // Long Press Context Menu Kapatıldı.
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        set {
            /* Don't set the menu here */
            /* super.menu = menu */
        }
        get { return super.menu }
    }
}
