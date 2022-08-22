//
//  BaseApiResponse.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import Foundation

// MARK: BaseRestApiResponse
struct BaseRestApiResponse<T: Codable>: Codable {
    var result: T?
}
