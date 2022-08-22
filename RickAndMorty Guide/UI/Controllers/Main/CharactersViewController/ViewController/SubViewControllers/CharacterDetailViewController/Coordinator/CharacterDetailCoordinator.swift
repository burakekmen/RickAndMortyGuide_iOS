//
//  CharacterDetailCoordinator.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.08.2022.
//

import UIKit

protocol ICharacterDetailCoordinator: AnyObject {
    
}

final class CharacterDetailCoordinator: NavigationCoordinator , ICharacterDetailCoordinator {

    private var coordinatorData: CharacterDetailPassData { return castPassData(CharacterDetailPassData.self) }

     override func start() {
        let controller = CharacterDetailBuilder.generate(with: coordinatorData, coordinator: self)
         navigationController.pushViewController(controller, animated: true)
     }
}
