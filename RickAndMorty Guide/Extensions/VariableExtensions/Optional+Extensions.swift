//
//  Optional+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension Optional {

    static func isNil(_ object: Wrapped) -> Bool {
        switch object as Any {
        case Optional<Any>.none:
            return true
        default:
            return false
        }
    }
}
