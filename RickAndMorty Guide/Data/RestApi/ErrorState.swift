//
//  ErrorState.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Foundation

enum ErrorState {
    case Error(errorType: NetworkingError)
    case ErrorComplete
}
