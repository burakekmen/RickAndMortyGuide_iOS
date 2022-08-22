//
//  FavoritesBuilder.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 2.08.2022.
// 

import UIKit

enum FavoritesBuilder {
    
    static func generate(with data: FavoritesPassData, 
                         coordinator: IFavoritesCoordinator) -> FavoritesViewController {
        let repository = FavoritesRepository(provider: createMoyaProvider(targetType: NoneService.self))
        let uiModel = FavoritesUIModel(data: data)
        let viewModel = FavoritesViewModel(repository: repository, 
                                                           coordinator: coordinator,
                                                           uiModel: uiModel)
        return FavoritesViewController(viewModel: viewModel)
    }
}
