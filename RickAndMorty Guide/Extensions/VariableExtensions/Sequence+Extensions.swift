//
//  Sequence+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

// MARK: HOW TO USE
/**
 
 // 1
 struct User {
     var name: String
     var nickname: String?
     var following: [User]
     var isOnline: Bool
 }

 // 2
 let userJeff = User(name: "Jeff", nickname: nil, following: [], isOnline: false)
 let userTom = User(name: "Tom", nickname: "Tommy", following: [userJeff], isOnline: true)
 let users = [userJeff, userTom]

 let names = users.map(\.name)

 // 6
 let nicknames = users.compactMap(\.nickname)
 // let nicknames = users.compactMap { $0.nickname }
 let following = users.flatMap(\.following)
 // let following = users.flatMap { $0.following }

 // 3
 let onlineUsers = users.filter(\.isOnline)
 // let onlineUsers = users.filter { $0.isOnline }
 // 4
 let friendNamesOfOnlineUsers = users.filter(\.isOnline).flatMap(\.following).map(\.name)
 
 */

extension Sequence {

    public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return self.map { $0[keyPath: keyPath] }
    }

    func compactMap<T>(_ keyPath: KeyPath<Element, T?>) -> [T] {
        return self.compactMap { $0[keyPath: keyPath] }
    }

    func flatMap<T>(_ keyPath: KeyPath<Element, [T]>) -> [T] {
        return self.flatMap { $0[keyPath: keyPath] }
    }

    func filter(_ keyPath: KeyPath<Element, Bool>) -> [Element] {
        return self.filter { $0[keyPath: keyPath] }
    }
}

