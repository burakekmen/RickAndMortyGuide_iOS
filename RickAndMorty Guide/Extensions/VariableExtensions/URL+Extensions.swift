//
//  URL+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension URL {

    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }

    // value kısımlarını, array içinde toplayıp döner.
    // ../?mahalle[]=m1&mahalle[]=m2&ilce[]=ilce1&deneme=123 -> url
    // ["ilce[]": ["ilce1"], "mahalle[]": ["m1", "m2"], "deneme": ["123"]] -> sonuç
    public var queryParametersWithArrayValues: [String: [String]]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }

        var parameters = [String: [String]]()
        for item in queryItems {
            if !parameters.keys.contains(item.name) {
                if let value = item.value {
                    parameters[item.name] = [value]
                }
            } else {
                if let value = item.value {

                    parameters[item.name]?.append(value)
                }
            }
        }
        return parameters
    }
}

