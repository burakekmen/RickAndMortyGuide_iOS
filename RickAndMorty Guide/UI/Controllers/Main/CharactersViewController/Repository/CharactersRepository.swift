//
//  CharactersRepository.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 23.05.2022.
//


import Foundation

protocol ICharactersRepository: AnyObject {

    func getAllCharacters(
        parameters: GetAllCharactersRequestParameters
    ) -> RestAPIResponseType<AllCharactersResponse>

    
    func getSomeCharacters(
        parameters: GetSomeCharactersRequestParameters
    ) -> RestAPIResponseType<[CharacterModel]>
}

class CharactersRepository: BaseRepository<CharacterService>, ICharactersRepository {
    func getAllCharacters(parameters: GetAllCharactersRequestParameters) -> RestAPIResponseType<AllCharactersResponse> {
        return requestRestApi(.allCharacters(parameters: parameters))
    }
    
    func getSomeCharacters(parameters: GetSomeCharactersRequestParameters) -> RestAPIResponseType<[CharacterModel]> {
        return requestRestApi(.someCharacters(parameters: parameters))
    }
}
