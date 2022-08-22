//
//  MainTabbarCoordinator.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit
import Localize

class MainTabbarCoordinator: RootableCoordinator {

    private lazy var mainTabbarController: MainTabbarController = {
        return MainTabbarController()
    }()
    
    override func start() {

        // Characters
        let charactersNavController = MainNavigationController()
        charactersNavController.tabBarItem.title = .tab_title_characters
        charactersNavController.tabBarItem.image = .ic_tab_characters.resizedImage(Size: CGSize(width: 24, height: 24))?.withRenderingMode(.alwaysOriginal)
        charactersNavController.tabBarItem.selectedImage = .ic_tab_characters_selected.resizedImage(Size: CGSize(width: 24, height: 24))?.withRenderingMode(.alwaysOriginal)
        let charactersCoordinator = CharactersCoordinator(navigationController: charactersNavController, hidesBar: true)

        // Favorites
        let favoritesNavController = MainNavigationController()
        favoritesNavController.tabBarItem.title = .tab_title_favorites
        favoritesNavController.tabBarItem.image = .ic_tab_favorites.resizedImage(Size: CGSize(width: 24, height: 24))?.withRenderingMode(.alwaysOriginal)
        favoritesNavController.tabBarItem.selectedImage = .ic_tab_favorites_selected.resizedImage(Size: CGSize(width: 24, height: 24))?.withRenderingMode(.alwaysOriginal)
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavController, hidesBar: true)

        // Episodes
        let episodesNavController = MainNavigationController()
        episodesNavController.tabBarItem.title = .tab_title_episodes
        episodesNavController.tabBarItem.image = .ic_tab_episodes.resizedImage(Size: CGSize(width: 24, height: 24))?.withRenderingMode(.alwaysOriginal)
        episodesNavController.tabBarItem.selectedImage = .ic_tab_episodes_selected.resizedImage(Size: CGSize(width: 24, height: 24))?.withRenderingMode(.alwaysOriginal)
        let episodesCoordinator = EpisodesCoordinator(navigationController: episodesNavController, hidesBar: true)

        
        mainTabbarController.viewControllers = [charactersNavController, favoritesNavController, episodesNavController]

        window?.rootViewController = mainTabbarController
        window?.makeKeyAndVisible()


        // Coordinate to first controllers for tabs
        coordinate(to: charactersCoordinator)
        coordinate(to: favoritesCoordinator)
        coordinate(to: episodesCoordinator)
    }
}


// Titles For Tab
extension String {
    static var tab_title_characters = "Characters".localize()
    static var tab_title_favorites = "Favorites".localize()
    static var tab_title_episodes = "Episodes".localize()
}

// Tab Icons
fileprivate extension UIImage {
    static var ic_tab_characters = UIImage(named: "ic_tab_1")!.withRenderingMode(.alwaysOriginal)
    static var ic_tab_characters_selected = UIImage(named: "ic_tab_1_selected")!.withRenderingMode(.alwaysOriginal)

    static var ic_tab_favorites = UIImage(named: "ic_tab_2")!.withRenderingMode(.alwaysOriginal)
    static var ic_tab_favorites_selected = UIImage(named: "ic_tab_2_selected")!.withRenderingMode(.alwaysOriginal)

    static var ic_tab_episodes = UIImage(named: "ic_tab_3")!.withRenderingMode(.alwaysOriginal)
    static var ic_tab_episodes_selected = UIImage(named: "ic_tab_3_selected")!.withRenderingMode(.alwaysOriginal)
}

