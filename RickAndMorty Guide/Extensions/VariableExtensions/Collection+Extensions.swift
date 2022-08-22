//
//  Collection+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension Collection {
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Optional where Wrapped: Collection {

    var isNotEmptyOrNil: Bool {
        return !isEmptyOrNil
    }

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
