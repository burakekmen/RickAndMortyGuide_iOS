//
//  Definitions.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Moya

// MARK: Provider
func createMoyaProvider<Target: TargetType>(targetType: Target.Type) -> MoyaProvider<Target> {
    // let provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin(configuration: .init())])
    let provider = MoyaProvider<Target>()
    provider.session.sessionConfiguration.timeoutIntervalForRequest = 120
    return provider
}

// Helper
func createMoyaProviderNoneService() -> MoyaProvider<NoneService> {
    return createMoyaProvider(targetType: NoneService.self)
}

// MARK: RequestParameters
typealias APIRequestParameters = [String: Any]

// MARK: Typealiases
typealias MoyaMethod = Moya.Method
typealias MoyaTask = Task

// MARK: Definitions
let DefaultJSONEncoding = JSONEncoding.default
let DefaultURLEncoding = URLEncoding.default

// MARK: TargetType - Header
public protocol MTargetType: TargetType {

    //var isAuthorization: Bool { get }
}

extension MTargetType {

    var baseURL: URL {
        return URL(string: NetworkUtil.environmentBaseURL)!
    }

    public var headers: [String: String]? {
        return [:]
//        var headers: [String: String] = [
//            "Content-Type": "application/json; charset=utf-8",
//            "X-FROM-CHANNEL": "CORPORATE_APP_IOS"
//        ]
//
//        if isAuthorization {
//            if let authToken = UserManager.shared.getAuthToken() {
//                headers["Authorization"] = authToken
//            }
//
//            if let refreshToken = UserManager.shared.getRefreshToken() {
//                headers["X-Refresh-Token"] = refreshToken
//            }
//        }

        //return headers
    }

    var sampleData: Data {
        return Data()
    }

    func generateEndPoint(lastPath: String) -> String {
        return NetworkUtil.generateMobileEndPointV1(lastPath: lastPath)
    }
}
