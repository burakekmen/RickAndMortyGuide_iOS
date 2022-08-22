//
//  FavoritesCoordinator.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 2.08.2022.
//

import UIKit

protocol IFavoritesCoordinator: AnyObject {
    func pushCharacterDetailViewController(with data: CharacterDetailPassData)
}

final class FavoritesCoordinator: NavigationCoordinator , IFavoritesCoordinator {

    //private var coordinatorData: FavoritesPassData { return castPassData(FavoritesPassData.self) }

     override func start() {
        let controller = FavoritesBuilder.generate(with: FavoritesPassData(), coordinator: self)
         navigationController.pushViewController(controller, animated: true)
     }
    
    func pushCharacterDetailViewController(with data: CharacterDetailPassData) {
        let characterDetailCoordinator =
            CharacterDetailCoordinator(navigationController: navigationController)
            .with(passData: data)
        
        coordinate(to: characterDetailCoordinator)
    }
}
