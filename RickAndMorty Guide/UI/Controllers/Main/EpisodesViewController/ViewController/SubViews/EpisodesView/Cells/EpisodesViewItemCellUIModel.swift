//
//  EpisodesViewItemCellUIModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 29.06.2022.
//

import UIKit

class EpisodesViewItemCellUIModel {

    private let episode : EpisodeModel

    init(episode: EpisodeModel) {
        self.episode = episode
    }

    var episodeName: String {
        return episode.name ?? ""
    }

    var episodePart: String {
        return episode.episode ?? ""
    }

    var episodeAirDate: String {
        return episode.air_date ?? ""
    }
    
    var episodeId : Int? {
        return episode.id
    }
}
