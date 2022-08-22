//
//  CharactersUIModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 23.05.2022.
//

import UIKit

protocol ICharactersUIModel {

	 init(data: CharactersPassData)

    mutating func setCharactersData(characters : [CharacterModel]?)
    mutating func setCharactersDataWithPagination(characters : [CharacterModel]?)
    func getCharactersData() -> [CharacterModel]?
    func getFilterValuesArray() ->[String]
    func getFilterValueWithIndex(index: Int) -> String
} 

struct CharactersUIModel: ICharactersUIModel {
    
	// MARK: Definitions
    var characters : [CharacterModel] = []
    private let filterValues = ["All", "Alive", "Dead"]

	// MARK: Initialize
    init(data: CharactersPassData) {

    }

    // MARK: Computed Props
    mutating func setCharactersData(characters : [CharacterModel]?) {
        self.characters = characters ?? []
    }
    
    mutating func setCharactersDataWithPagination(characters : [CharacterModel]?) {
        self.characters.append(contentsOf: characters ?? [])
    }
    
    func getCharactersData() -> [CharacterModel]? {
        return characters
    }
    
    func getFilterValuesArray() ->[String] {
        return filterValues
    }
    
    func getFilterValueWithIndex(index: Int) -> String {
        return filterValues[index]
    }
}
