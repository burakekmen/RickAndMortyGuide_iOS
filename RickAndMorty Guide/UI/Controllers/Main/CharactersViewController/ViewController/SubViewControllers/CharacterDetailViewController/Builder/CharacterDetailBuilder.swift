//
//  CharacterDetailBuilder.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.08.2022.
// 

import UIKit

enum CharacterDetailBuilder {
    
    static func generate(with data: CharacterDetailPassData, 
                         coordinator: ICharacterDetailCoordinator) -> CharacterDetailViewController {
        let repository = CharacterDetailRepository(provider: createMoyaProvider(targetType: CharacterService.self))
        let episodeRepository = EpisodesRepository(provider: createMoyaProvider(targetType: EpisodeService.self))
        let uiModel = CharacterDetailUIModel(data: data)
        let viewModel = CharacterDetailViewModel(repository: repository,
                                                 episodeRepository:episodeRepository,
                                                coordinator: coordinator,
                                                uiModel: uiModel)
        
        return CharacterDetailViewController(viewModel: viewModel)
    }
}
