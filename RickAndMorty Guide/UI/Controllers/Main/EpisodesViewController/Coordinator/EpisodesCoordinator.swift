//
//  EpisodesCoordinator.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 26.05.2022.
//

import UIKit

protocol IEpisodesCoordinator: AnyObject {
    func pushEpisodeDetailViewController(with data: EpisodeDetailPassData)
}

final class EpisodesCoordinator: NavigationCoordinator , IEpisodesCoordinator {

    //private var coordinatorData: EpisodesPassData { return castPassData(EpisodesPassData.self) }

     override func start() {
         let controller = EpisodesBuilder.generate(with: EpisodesPassData(), coordinator: self)
         navigationController.pushViewController(controller, animated: true)
     }
    
    func pushEpisodeDetailViewController(with data: EpisodeDetailPassData) {
        let episodeDetailCoordinator =
            EpisodeDetailCoordinator(navigationController: navigationController)
            .with(passData: data)
        
        coordinate(to: episodeDetailCoordinator)
    }
}
