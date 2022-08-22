//
//  MainTabbarController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit
import Localize

enum MainTabbarItemPosition: Int {
    case characters = 0
    case favorites = 1
    case episodes = 2
}

final class MainTabbarController: UITabBarController {
    
    private lazy var customTabbar: RAMTabbar = {
        let t = RAMTabbar(frame: tabBar.frame)
        t.makeDefaultAppStyle()
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabbar, forKey: "tabBar")
        view.backgroundColor = .baseBackgroundColor
    }
    
    func changeTabbarItemController(position: MainTabbarItemPosition) {
        self.selectedIndex = position.rawValue
    }
}

// MARK: Tabbar Methods
extension MainTabbarController {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx,
            let imageView = tabBar.subviews[idx].subviews.compactMap({ $0 as? UIImageView }).first else {
            return
        }
        
//        switch item.title {
//        case String.tab_title_characters:
//            customTabbar.tabbarColor = .characterTabColor
//            customTabbar.draw(customTabbar.frame)
//            self.showToast(message: "Characters tab clicked")
//        case String.tab_title_favorites:
//            customTabbar.tabbarColor = .favoriteTabColor
//            customTabbar.draw(customTabbar.frame)
//        case String.tab_title_episodes:
//            customTabbar.tabbarColor = .episodeTabColor
//            customTabbar.draw(customTabbar.frame)
//            self.showToast(message: "Episodes tab clicked")
//        default:
//            break
//        }
        
        
        
        imageView.bounceAnimation()
    }
}
