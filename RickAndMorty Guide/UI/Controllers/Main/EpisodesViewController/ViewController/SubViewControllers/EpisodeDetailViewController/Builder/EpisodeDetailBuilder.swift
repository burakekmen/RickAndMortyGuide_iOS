//
//  EpisodeDetailBuilder.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 11.08.2022.
// 

import UIKit

enum EpisodeDetailBuilder {
    
    static func generate(with data: EpisodeDetailPassData, 
                         coordinator: IEpisodeDetailCoordinator) -> EpisodeDetailViewController {
        let repository = EpisodeDetailRepository(provider: createMoyaProvider(targetType: EpisodeService.self))
        let characterRepository = CharactersRepository(provider: createMoyaProvider(targetType: CharacterService.self))
        let uiModel = EpisodeDetailUIModel(data: data)
        let viewModel = EpisodeDetailViewModel(repository: repository,
                                               characterRepository: characterRepository,
                                                           coordinator: coordinator,
                                                           uiModel: uiModel)
        return EpisodeDetailViewController(viewModel: viewModel)
    }
}
