//
//  EpisodesBuilder.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 26.05.2022.
// 

import UIKit

enum EpisodesBuilder {
    
    static func generate(with data: EpisodesPassData, 
                         coordinator: IEpisodesCoordinator) -> EpisodesViewController {
        
        let repository = EpisodesRepository(provider: createMoyaProvider(targetType: EpisodeService.self))
        let uiModel = EpisodesUIModel(data: data)
        let viewModel = EpisodesViewModel(repository: repository, 
                                                           coordinator: coordinator,
                                                           uiModel: uiModel)
        
        return EpisodesViewController(viewModel: viewModel)
    }
}
