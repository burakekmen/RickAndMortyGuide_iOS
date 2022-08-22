//
//  GetAllEpisodesRequestParameters.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 29.06.2022.
//

import Foundation

struct GetAllEpisodesRequestParameters : Codable {
    let filters : GetAllEpisodesFiltersParameters?
}


struct GetAllEpisodesFiltersParameters : Codable {
    
    let episode : String?
    
    // episode?episode=S01
    var getFiltersValue : String {
        var tempFilter = "?"
        
        if let _episode = self.episode {
            tempFilter = "\(tempFilter)episode=\(_episode)"
        }
        
        if tempFilter != "?" {
            return tempFilter
        }else {
            return ""
        }
    }
}
