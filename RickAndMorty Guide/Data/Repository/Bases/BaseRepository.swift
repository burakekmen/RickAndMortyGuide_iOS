//
//  BaseRepository.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 21.05.2022.
//

import Moya
import ReactiveKit

typealias RestAPIResponseType<ResultData: Codable> = Signal<Resource<ResultData>, Never>
typealias RestAPIBaseResponseType<ResultData: Codable> = Signal<Resource<BaseRestApiResponse<ResultData>>, Never>

protocol IBaseRepository { }

class BaseRepository<Target: TargetType>: IBaseRepository {

    private let disposeBagForRefreshToken = DisposeBag()

    deinit {
        print("killed: \(type(of: self))")
    }

    private var provider: MoyaProvider<Target>

    init(provider: MoyaProvider<Target>) {
        self.provider = provider
    }
}

// MARK: Rest
internal extension BaseRepository {

    func requestRestApi<T: Codable>(_ target: Target) -> RestAPIResponseType<T> {
        return Signal { (observer) -> Disposable in
            self.provider.request(target) { (result) in
                switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    
                    if statusCode >= 200 && statusCode < 300 {
                        do {
                            let response = try JSONDecoder().decode(T.self, from: response.data)
                            observer.on(.next(Resource.success(response)))
                        } catch (let error) {
                            print("##############################")
                            print("response parse error: \(error)")
                            print("##############################")
                            observer.on(.next(Resource.failure(errorType: .UNDEFINED_RESPONSE_TYPE)))
                        }
                    } else {
                        do {
                            let parentErrorResponse = try JSONDecoder().decode(RestApiErrorResponse.self, from: response.data)

                            let networkingError = self.handleError(
                                errorResponse: RestApiErrorResponse(error: parentErrorResponse.error)
                            )
                            observer.on(.next(Resource.failure(errorType: networkingError)))
                        } catch {
                            observer.on(.next(Resource.failure(errorType: .DEFAULT_ERROR(message: fetchLocalizeString(key: .str_commonErrorMesage)))))
                        }
                    }
                case .failure(let error):
                    switch error {
                    case .underlying(let underlyingError, _):
                        switch underlyingError.asAFError {
                        case .sessionTaskFailed(let sessionTaskFailedError):
                            let nsErrorCode = (sessionTaskFailedError as NSError).code
                            if nsErrorCode == -1009 { // no internet
                                observer.on(.next(Resource.failure(errorType: .NO_CONNECTION_NETWORK)))
                            } else if nsErrorCode == NSURLErrorTimedOut {
                                observer.on(.next(Resource.failure(errorType: .TIMED_OUT_ERROR)))
                            }
                        default:
                            observer.on(.next(Resource.failure(errorType: .DEFAULT_ERROR(message: fetchLocalizeString(key: .str_commonErrorMesage)))))
                        }
                    default:
                        observer.on(.next(Resource.failure(errorType: .DEFAULT_ERROR(message: fetchLocalizeString(key: .str_commonErrorMesage)))))
                    }
                }
            }

            return SimpleDisposable(isDisposed: false)
        }
    }
}

private extension BaseRepository {
    func handleError(errorResponse: RestApiErrorResponse) -> NetworkingError {
        let error = errorResponse.error

        return .DEFAULT_ERROR(message: error)
    }
}
