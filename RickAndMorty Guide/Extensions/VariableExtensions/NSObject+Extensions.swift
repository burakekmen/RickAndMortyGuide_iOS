//
//  NSObject+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }

    var classNameForInstance: String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }
}

