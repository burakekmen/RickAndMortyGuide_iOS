//
//  SplashBuilder.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
// 

import UIKit

enum SplashBuilder {
    
    static func generate(coordinator: ISplashCoordinator) -> SplashViewController {
        let repository = SplashRepository(provider: createMoyaProviderNoneService())
        let uiModel = SplashUIModel()
        let viewModel = SplashViewModel(repository: repository, 
                                                           coordinator: coordinator,
                                                           uiModel: uiModel)
        return SplashViewController(viewModel: viewModel)
    }
}
