//
//  EpisodeDetailCoordinator.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 11.08.2022.
//

import UIKit

protocol IEpisodeDetailCoordinator: AnyObject {
    func pushCharacterDetailViewController(with data: CharacterDetailPassData)
}

final class EpisodeDetailCoordinator: NavigationCoordinator , IEpisodeDetailCoordinator {

    private var coordinatorData: EpisodeDetailPassData { return castPassData(EpisodeDetailPassData.self) }

     override func start() {
        let controller = EpisodeDetailBuilder.generate(with: coordinatorData, coordinator: self)
        navigationController.pushViewController(controller, animated: true)
     }
    
    func pushCharacterDetailViewController(with data: CharacterDetailPassData) {
        let characterDetailCoordinator =
            CharacterDetailCoordinator(navigationController: navigationController)
            .with(passData: data)
        
        coordinate(to: characterDetailCoordinator)
    }
}
