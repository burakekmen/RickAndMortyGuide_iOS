//
//  EpisodesViewUIModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 29.06.2022.
//

import Foundation

class EpisodesViewUIModel {

    // MARK: Inject
    private var cellUIModels: [EpisodesViewItemCellUIModel] = []
    
    init(episodes: [EpisodeModel]) {
        self.mappedToCellUIModels(episodes: episodes)
    }

    func getNumberOfItemsInSection() -> Int {
        return cellUIModels.count
    }

    func getCellUIModel(at index: Int) -> EpisodesViewItemCellUIModel {
        return cellUIModels[index]
    }
}


// MARK: Mapper
private extension EpisodesViewUIModel {

    func mappedToCellUIModels(episodes: [EpisodeModel]) {
        self.cellUIModels = episodes.enumerated().compactMap { (index, element) in
            let episodeModel = EpisodeModel(
                id: element.id,
                name: element.name,
                air_date: element.air_date,
                episode: element.episode,
                characters: element.characters,
                url: element.url,
                created: element.created)
            return EpisodesViewItemCellUIModel(episode: episodeModel)
        }
    }
}
