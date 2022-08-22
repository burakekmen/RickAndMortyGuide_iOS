//
//  EpisodeDetailUIModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 11.08.2022.
//

import UIKit

protocol IEpisodeDetailUIModel {

	 init(data: EpisodeDetailPassData)

    func getEpisodeId() -> Int?
    func getCharactersIds() -> String?
    func getEpisodeDetail() -> EpisodeModel?
    func getEpisodeCharacters() -> [CharacterModel]?
    mutating func setEpisodeDetailResponse(episodeModel : EpisodeModel?)
    mutating func setCharactersResponse(charactersModel : [CharacterModel]?)
} 

struct EpisodeDetailUIModel: IEpisodeDetailUIModel {

	// MARK: Definitions
    private let episodeId: Int?
    private var episodeDetailResponse : EpisodeModel?
    private var episodeCharacters : [CharacterModel]?
    private var characters: String = ""

	// MARK: Initialize
    init(data: EpisodeDetailPassData) {
        self.episodeId = data.episodeId
    }

    // MARK: Computed Props
    func getEpisodeId() -> Int? {
        return episodeId
    }
    
    func getCharactersIds() -> String? {
        return characters
    }
    
    func getEpisodeDetail() -> EpisodeModel? {
        guard let episode = episodeDetailResponse else { return nil }
        
        return episode
    }
    
    func getEpisodeCharacters() -> [CharacterModel]? {
        return episodeCharacters
    }
    
    mutating func setEpisodeDetailResponse(episodeModel : EpisodeModel?) {
        guard let episode = episodeModel else { return }
        self.episodeDetailResponse = episode
        self.getCharacters()
    }
    
    mutating func setCharactersResponse(charactersModel : [CharacterModel]?) {
        guard let _characters = charactersModel else { return }
        self.episodeCharacters = _characters
    }
}

// MARK: Props
extension EpisodeDetailUIModel {
    private mutating func getCharacters() {
        if let tempCharacters = episodeDetailResponse?.characters {
            for character in tempCharacters {
                if let index = character.lastIndex(of: "/") {
                    var characterId = character.suffix(from: index)
                    characterId.removeFirst()
                    characters.append("\(String(characterId)),")
                }
            }
        }
        
        if self.characters.isNotEmpty {
            self.characters.removeLast()
        }
        
        print("Characters: \(self.characters)")
    }
}
