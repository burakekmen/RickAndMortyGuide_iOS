//
//  EpisodeService.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 29.06.2022.
//

import Moya

enum EpisodeService {
    case allEpisodes(parameters: GetAllEpisodesRequestParameters)
    case singleEpisodes(parameters: GetSomeEpisodesRequestParameters)
    case multiEpisodes(parameters: GetSomeEpisodesRequestParameters)
    case episodeDetail(parameters: GetEpisodeDetailRequestParameters)
}

extension EpisodeService: MTargetType {

    var path: String {
        switch self {
        case .allEpisodes(_):
            return generateEndPoint(lastPath: "/episode")
        case .singleEpisodes(let parameters), .multiEpisodes(let parameters):
            return generateEndPoint(lastPath: "/episode/\(parameters.episodes)")
        case .episodeDetail(let parameters):
            return generateEndPoint(lastPath: "/episode/\(parameters.episodeId)")
        }
    }

    var method: MoyaMethod {
        switch self {
        case .allEpisodes(_),
                .singleEpisodes(_),
                .multiEpisodes(_),
                .episodeDetail(_):
            return .get
        }
    }

    var task: MoyaTask {
        switch self {
        case .singleEpisodes(_), .multiEpisodes(_), .episodeDetail(_):
            return .requestPlain
        case .allEpisodes(let parameters):
            var tempParameters = [String:Any]()
            
            if let episode = parameters.filters?.episode {
                tempParameters["episode"] = episode
            }
            
            return .requestParameters(parameters: tempParameters, encoding: DefaultURLEncoding)
        }
    }
}
