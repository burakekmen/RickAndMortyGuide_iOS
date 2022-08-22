//
//  UserManager.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Foundation
import UIKit

class UserManager {

    static let shared = UserManager()

    var defaults: Defaults? = nil

    private init() {
        defaults = Defaults()
    }

}


extension UserManager {

    public func getFavorites() -> [CharacterModel] {
        return defaults?.get(for: .favoriteCharactersObject) ?? []
    }
    
    func addFavorite (value : CharacterModel) {
        var favorites = getFavorites()
        favorites.append(value)
        
        defaults?.set(favorites, for: .favoriteCharactersObject)
    }
    
    func removeFavorite (value : CharacterModel) {
        var favorites = getFavorites()
        
        if let index = favorites.firstIndex(where: { $0.id == value.id }) {
            favorites.remove(at: index)
            defaults?.set(favorites, for: .favoriteCharactersObject)
        }
    }
    
    func isCharacterInFavorite(id: Int) -> Bool {
        let favorites = getFavorites()
        
        if favorites.contains(where: {$0.id == id}) {
            return true
        } else {
            return false
        }
    }

    public func resetFavorites() {
        defaults?.clear(.favoriteCharactersObject)
    }
}

internal extension DefaultsKey {
    static let favoriteCharactersObject = Key<[CharacterModel]>("FavoriteCharactersObject")
}
