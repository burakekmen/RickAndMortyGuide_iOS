//
//  AllCharacterResponse.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 28.05.2022.
//

import Foundation

struct AllCharactersResponse: Codable {
    var info: InfoModel?
    var results: [CharacterModel]?
}


struct InfoModel : Codable {
    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?
}

struct CharacterModel : Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: OriginModel?
    var location: LocationModel?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
    
    var statusFormatted : CharactersStatusEnum {
        
        if let tempStatus = self.status {
            switch tempStatus {
            case "alive", "Alive":
                return .alive
            case "dead", "Dead":
                return .dead
            default:
                return .unknown
            }
        }else {
            return .unknown
        }
    }
}


struct OriginModel : Codable {
    var name: String?
    var url: String?
}

struct LocationModel : Codable {
    var name: String?
    var url: String?
}
