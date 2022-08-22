//
//  EpisodeDetailRepository.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 11.08.2022.
//

import Foundation

protocol IEpisodeDetailRepository: AnyObject {
    func getEpisodeDetail(
        parameters: GetEpisodeDetailRequestParameters
    ) -> RestAPIResponseType<EpisodeModel>
}

final class EpisodeDetailRepository: BaseRepository<EpisodeService>, IEpisodeDetailRepository {

    func getEpisodeDetail(parameters: GetEpisodeDetailRequestParameters) -> RestAPIResponseType<EpisodeModel> {
        return requestRestApi(.episodeDetail(parameters: parameters))
    }
} 
