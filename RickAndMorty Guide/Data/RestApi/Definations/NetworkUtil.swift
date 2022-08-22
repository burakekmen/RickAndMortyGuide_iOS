//
//  NetworkUtil.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Foundation

enum APIEnvironment {
    case production
}

struct NetworkUtil {
    private static let environment: APIEnvironment = .production

    static var environmentBaseURL: String {
        switch NetworkUtil.environment {
        case .production: return "https://rickandmortyapi.com/"
        }
    }

    static func generateMobileEndPointV1(lastPath: String) -> String {
        return "api\(lastPath)"
    }
}
