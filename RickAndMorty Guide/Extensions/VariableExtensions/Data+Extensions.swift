//
//  Data+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension Data {

    var sizeInBytes: Int {
        let byteCount = self.count
        return byteCount
    }

    var sizeInBits: Int {
        let bitCount = sizeInBytes * 8
        return bitCount
    }

    init?(json: Any) {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed) else { return nil }
        self.init(data)
    }

    func jsonToDictionary() -> [String: Any]? {
        (try? JSONSerialization.jsonObject(with: self, options: .allowFragments)) as? [String: Any]
    }

    func jsonToArray() -> [Any]? {
        (try? JSONSerialization.jsonObject(with: self, options: .allowFragments)) as? [Any]
    }
    
    func decodeToCodable<T:Codable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
