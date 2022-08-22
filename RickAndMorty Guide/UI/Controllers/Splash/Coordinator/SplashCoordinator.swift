//
//  SplashCoordinator.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit

protocol ISplashCoordinator: AnyObject {
    
}

final class SplashCoordinator: RootableCoordinator , ISplashCoordinator {

     override func start() {
         let controller = SplashBuilder.generate(coordinator: self)
         window?.rootViewController = controller
         window?.makeKeyAndVisible()
     }
}
