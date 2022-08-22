//
//  NetworkingError.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Foundation

private let networkConnectionMessage = fetchLocalizeString(key: .str_please_check_your_network_connection)
private let commonErrorMesage = fetchLocalizeString(key: .str_commonErrorMesage)
private let serverErrorMessage = fetchLocalizeString(key: .str_serverErrorMessage)
private let undefinedResponseMessage = fetchLocalizeString(key: .str_undefinedResponseMessage)

struct LocalizableApiErrorMessage: Codable {
    let tr: String?
    let en: String?
}

enum NetworkingError: CustomStringConvertible {
    case NO_CONNECTION_NETWORK
    case TIMED_OUT_ERROR
    case HTTP_EXCEPTION(statusCode: Int, message: String?)
    case DEFAULT_ERROR(message: String?)
    case UNDEFINED_RESPONSE_TYPE

    var description: String {
        switch self {
        case .NO_CONNECTION_NETWORK:
            return networkConnectionMessage
        case .TIMED_OUT_ERROR:
            return serverErrorMessage
        case .HTTP_EXCEPTION(let statusCode, let message):
            switch statusCode {
            case 401:
                return "Authorization"
            case 406, 500:
                return serverErrorMessage
            default:
                return message ?? serverErrorMessage
            }
        case .DEFAULT_ERROR(let message):
            return message ?? commonErrorMesage
        case .UNDEFINED_RESPONSE_TYPE:
            return undefinedResponseMessage
        }
    }
}
