//
//  AppCoordinator.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import UIKit

protocol AppCoordinatorFlow: AnyObject {
    func startFlowMain()
    // func startsWithDeeplink(_...) { }
    // func startsWithApplink(_...) { }
}

class AppCoordinator: RootableCoordinator, AppCoordinatorFlow {

    override func start() {
        let splashCoordinator = SplashCoordinator(window: self.window)
        coordinate(to: splashCoordinator)
    }

    func startFlowMain() {
        let tabbarCoordinator = MainTabbarCoordinator(window: self.window)
        coordinate(to: tabbarCoordinator)
    }

    // func startsWithDeeplink(_...) { }
    // func startsWithApplink(_...) { }
}

