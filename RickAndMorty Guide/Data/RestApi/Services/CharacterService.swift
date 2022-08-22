//
//  CharacterServices.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 21.05.2022.
//

import Moya

enum CharacterService {
    case allCharacters(parameters: GetAllCharactersRequestParameters)
    case someCharacters(parameters: GetSomeCharactersRequestParameters)
    case characterDetail(parameters: GetCharacterDetailRequestParameters)
}

extension CharacterService: MTargetType {

    var path: String {
        switch self {
        case .allCharacters(_):
            return generateEndPoint(lastPath: "/character")
        case .someCharacters(let parameters):
            return generateEndPoint(lastPath: "/character/\(parameters.characters)")
        case .characterDetail(let parameters):
            return generateEndPoint(lastPath: "/character/\(parameters.id)")
        }
    }

    var method: MoyaMethod {
        switch self {
        case .allCharacters(_),
                .someCharacters(_),
            .characterDetail(_):
            return .get
        }
    }

    var task: MoyaTask {
        switch self {
        case .characterDetail(_), .someCharacters(_):
            return .requestPlain
        case .allCharacters(let parameters):
            var tempParameters = [String:Any]()
            
            if let page = parameters.filters?.page {
                tempParameters["page"] = page
            }
            
            if let status = parameters.filters?.status {
                tempParameters["status"] = status
            }
            
            if let name = parameters.filters?.name {
                tempParameters["name"] = name
            }
            
            return .requestParameters(parameters: tempParameters, encoding: DefaultURLEncoding)
        }
    }
}
