//
//  CharacterDetailRepository.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.08.2022.
//

import Foundation

protocol ICharacterDetailRepository: AnyObject {
    func getCharacterDetail(
        parameters: GetCharacterDetailRequestParameters
    ) -> RestAPIResponseType<CharacterModel>
}


final class CharacterDetailRepository: BaseRepository<CharacterService>, ICharacterDetailRepository {

    func getCharacterDetail(parameters: GetCharacterDetailRequestParameters) -> RestAPIResponseType<CharacterModel> {
        return requestRestApi(.characterDetail(parameters: parameters))
    }
}
