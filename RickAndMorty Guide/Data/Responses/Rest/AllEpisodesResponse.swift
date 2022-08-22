//
//  AllEpisodesResponse.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 29.06.2022.
//

import Foundation

struct AllEpisodesResponse: Codable {
    var info: InfoModel?
    var results: [EpisodeModel]?
}


struct EpisodeModel : Codable {
    var id: Int?
    var name: String?
    var air_date: String?
    var episode: String?
    var characters : [String]?
    var url : String?
    var created : String?
}

