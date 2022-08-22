//
//  SplashRepository.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Foundation

protocol ISplashRepository: AnyObject {
}

final class SplashRepository: BaseRepository<NoneService>, ISplashRepository {
} 
