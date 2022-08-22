//
//  Resource.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Foundation

enum Resource<T: Codable> {
    case empty
    case success(T)
    case failure(errorType: NetworkingError)
}
