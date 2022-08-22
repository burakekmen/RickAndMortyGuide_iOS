//
//  String+Optional.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension Optional where Wrapped == String {

    var isNilOrWhiteSpace: Bool {
        return self?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
    }

    func toWrapValue() -> String {
        return self ?? ""
    }
}
