//
//  EpisodesUIModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 26.05.2022.
//

import UIKit

protocol IEpisodesUIModel {

	 init(data: EpisodesPassData)

    mutating func setEpisodesData(episodes : [EpisodeModel]?)
    func getEpisodesData() -> [EpisodeModel]?
    func getSeasonValuesArray() ->[String]
    func getSeasonValueWithIndex(index: Int) -> String
} 

struct EpisodesUIModel: IEpisodesUIModel {

	// MARK: Definitions
    private var episodes : [EpisodeModel]?
    private let seasonValues = ["Season 1","Season 2","Season 3","Season 4","Season 5"]
    
	// MARK: Initialize
    init(data: EpisodesPassData) {

    }

    // MARK: Computed Props
    mutating func setEpisodesData(episodes : [EpisodeModel]?) {
        self.episodes = episodes
    }
    
    func getEpisodesData() -> [EpisodeModel]?{
        return episodes
    }
    
    func getSeasonValuesArray() ->[String] {
        return seasonValues
    }
    
    func getSeasonValueWithIndex(index: Int) -> String {
        return seasonValues[index]
    }
}

// MARK: Props
extension EpisodesUIModel {

}
