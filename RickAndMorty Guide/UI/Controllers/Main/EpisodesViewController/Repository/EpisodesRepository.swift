//
//  EpisodesRepository.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 26.05.2022.
//

import Foundation

protocol IEpisodesRepository: AnyObject {
    func getAllEpisodes(parameters: GetAllEpisodesRequestParameters) -> RestAPIResponseType<AllEpisodesResponse>
    func getSingleEpisodes(parameters: GetSomeEpisodesRequestParameters) -> RestAPIResponseType<EpisodeModel>
    func getMultiEpisodes(parameters: GetSomeEpisodesRequestParameters) -> RestAPIResponseType<[EpisodeModel]>
}
final class EpisodesRepository: BaseRepository<EpisodeService>, IEpisodesRepository {
    
    func getAllEpisodes(parameters: GetAllEpisodesRequestParameters) -> RestAPIResponseType<AllEpisodesResponse> {
        return requestRestApi(.allEpisodes(parameters: parameters))
    }
    
    func getSingleEpisodes(parameters: GetSomeEpisodesRequestParameters) -> RestAPIResponseType<EpisodeModel> {
        return requestRestApi(.singleEpisodes(parameters: parameters))
    }
    
    func getMultiEpisodes(parameters: GetSomeEpisodesRequestParameters) -> RestAPIResponseType<[EpisodeModel]> {
        return requestRestApi(.multiEpisodes(parameters: parameters))
    }
} 
