//
//  GetAllCharactersRequestParameters.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 21.05.2022.
//

import Foundation

struct GetAllCharactersRequestParameters : Codable {
    let filters : GetAllCharactersFiltersParameters?
}


struct GetAllCharactersFiltersParameters : Codable {
    let page : Int?
    let name : String?
    let status : String?
    
    // characters?page=1&name=Morty&status=Alive
    var getFiltersValue : String {
        var tempFilter = "?"
        
        if let page = self.page {
            tempFilter = "\(tempFilter)page=\(page)"
        }
        
        if tempFilter != "?" {
            return tempFilter
        }else {
            return ""
        }
    }
}
