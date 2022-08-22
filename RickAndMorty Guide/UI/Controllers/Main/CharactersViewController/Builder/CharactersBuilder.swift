//
//  CharactersBuilder.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 23.05.2022.
// 

import UIKit

enum CharactersBuilder {
    
    static func generate(with data: CharactersPassData, 
                         coordinator: ICharactersCoordinator) -> CharactersViewController {
        
        let repository = CharactersRepository(provider: createMoyaProvider(targetType: CharacterService.self))
        let uiModel = CharactersUIModel(data: data)
        let viewModel = CharactersViewModel(repository: repository, 
                                                           coordinator: coordinator,
                                                           uiModel: uiModel)
        return CharactersViewController(viewModel: viewModel)
    }
}
