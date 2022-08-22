//
//  ReachabilityManager.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import Reachability

class ReachabilityManager {

    static let shared = ReachabilityManager()

    private init() { }

    func isNetworkAvailable() -> Bool {
        if let reachability = try? Reachability() {
            return reachability.connection != .unavailable
        }
        return false
    }

}

