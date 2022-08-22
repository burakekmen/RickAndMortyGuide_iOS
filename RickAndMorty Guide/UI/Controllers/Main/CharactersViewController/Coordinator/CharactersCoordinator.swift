//
//  CharactersCoordinator.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 23.05.2022.
//

import UIKit

protocol ICharactersCoordinator: AnyObject {
    func pushCharacterDetailViewController(with data: CharacterDetailPassData)
}

final class CharactersCoordinator: NavigationCoordinator , ICharactersCoordinator {

    //private var coordinatorData: CharactersPassData { return castPassData(CharactersPassData.self) }

     override func start() {
        let controller = CharactersBuilder.generate(with: CharactersPassData(), coordinator: self)
        navigationController.pushViewController(controller, animated: true)
     }
    
    func pushCharacterDetailViewController(with data: CharacterDetailPassData) {
        let characterDetailCoordinator =
            CharacterDetailCoordinator(navigationController: navigationController)
            .with(passData: data)
        
        coordinate(to: characterDetailCoordinator)
    }
}
