//
//  CharactersViewItemCellUIModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.06.2022.
//

import Foundation

enum CharactersStatusEnum {
    case alive
    case dead
    case unknown
    
    var desc:String {
        switch self {
        case .alive:
            return "Alive"
        case .dead:
            return "Dead"
        case .unknown:
            return "Unknown"
        }
    }
}

struct CharactersViewItemCellUIModel {

    var character : CharacterModel

    var imageUrl : String {
        return character.image ?? ""
    }
    
    var name : String {
        return character.name ?? ""
    }
    
    var status : CharactersStatusEnum {
        
        if let tempStatus = character.status {
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
    
    var species : String {
        return character.species ?? ""
    }
    
    var gender : String {
        return character.gender ?? ""
    }
    
    var origin : String {
        if let originName = character.origin?.name {
            let text = " (Replacement Dimension)"
            if originName.contains(text) {
                return originName.replacingOccurrences(of: text, with: "")
            }else {
                return character.origin?.name ?? ""
            }
        }else {
            return ""
        }
    }
}
