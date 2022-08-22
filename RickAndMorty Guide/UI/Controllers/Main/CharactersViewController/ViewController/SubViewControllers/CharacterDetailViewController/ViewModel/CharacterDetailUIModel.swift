//
//  CharacterDetailUIModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 7.08.2022.
//

import UIKit

protocol ICharacterDetailUIModel {

	 init(data: CharacterDetailPassData)

    func getCharacterId() -> Int?
    mutating func setCharacterDetailResponse(characterModel : CharacterModel?)
    mutating func setEpisodesResponse(episodesModel : [EpisodeModel]?)
    func getCharacterDetail() -> CharacterModel?
    func getCharacterEpisodes() -> [EpisodeModel]?
    func getEpisodeIds() -> String
} 

struct CharacterDetailUIModel: ICharacterDetailUIModel {

	// MARK: Definitions
    private let characterId : Int?
    var characterDetailResponse : CharacterModel?
    var characterEpisodes : [EpisodeModel]?
    var episodes : String = ""

	// MARK: Initialize
    init(data: CharacterDetailPassData) {
        self.characterId = data.characterId
    }

    // MARK: Computed Props
    
    func getCharacterId() -> Int? {
        return characterId
    }
    
    func getEpisodeIds() -> String {
        return episodes
    }
    
    func getCharacterDetail() -> CharacterModel? {
        guard let character = characterDetailResponse else { return nil }
        
        return character
    }
    
    func getCharacterEpisodes() -> [EpisodeModel]? {
        guard let episodes = characterEpisodes else { return nil }
        
        return episodes
    }
    
    mutating func setCharacterDetailResponse(characterModel : CharacterModel?) {
        guard let character = characterModel else { return }
        self.characterDetailResponse = character
        self.getEpisodes()
    }
    
    mutating func setEpisodesResponse(episodesModel : [EpisodeModel]?) {
        guard let _episodes = episodesModel else { return }
        self.characterEpisodes = _episodes
    }
}

// MARK: Props
extension CharacterDetailUIModel {
    private mutating func getEpisodes() {
        if let tempEpisodes = characterDetailResponse?.episode {
            for episode in tempEpisodes {
                if let index = episode.lastIndex(of: "/") {
                    var episodeId = episode.suffix(from: index)
                    episodeId.removeFirst()
                    episodes.append("\(String(episodeId)),")
                }
            }
        }
        
        if self.episodes.isNotEmpty {
            self.episodes.removeLast()
        }
        
        print("Episodes: \(self.episodes)")
    }
}
