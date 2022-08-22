//
//  String+Json.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension String {
    init?(json: Any) {
        guard let data = Data(json: json) else { return nil }
        self.init(decoding: data, as: UTF8.self)
    }

    func jsonToDictionary() -> [String: Any]? {
        self.data(using: .utf8)?.jsonToDictionary()
    }

    func jsonToArray() -> [Any]? {
        self.data(using: .utf8)?.jsonToArray()
    }
}
