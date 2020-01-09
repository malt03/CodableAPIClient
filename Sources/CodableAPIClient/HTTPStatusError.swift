//
//  HTTPStatusError.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/09.
//

import Foundation

enum HTTPStatusCodeError: Int, Error {
    case unknown = -1
    
    // 400 Client Error
    case badRequest = 400
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case proxyAuthenticationRequired
    case requestTimeout
    case conflict
    case gone
    case lengthRequired
    case preconditionFailed
    case payloadTooLarge
    case uriTooLong
    case unsupportedMediaType
    case rangeNotSatisfiable
    case expectationFailed
    case imATeapot
    case misdirectedRequest = 421
    case unprocessableEntity
    case locked
    case failedDependency
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests
    case requestHeaderFieldsTooLarge = 431
    case unavailableForLegalReasons = 451
    
    // 500 Server Error
    case internalServerError = 500
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case httpVersionNotSupported
    case variantAlsoNegotiates
    case insufficientStorage
    case loopDetected
    case notExtended = 510
    case networkAuthenticationRequired
    
    private var text: String {
        switch self {
        case .unknown: return "Unknwon"
        
        case .badRequest: return "Bad Request"
        case .unauthorized: return "Unauthorized"
        case .paymentRequired: return "Payment Required"
        case .forbidden: return "Forbidden"
        case .notFound: return "Not Found"
        case .methodNotAllowed: return "Method Not Allowed"
        case .notAcceptable: return "Not Acceptable"
        case .proxyAuthenticationRequired: return "Proxy Authentication Required"
        case .requestTimeout: return "Request Timeout"
        case .conflict: return "Conflict"
        case .gone: return "Gone"
        case .lengthRequired: return "Length Required"
        case .preconditionFailed: return "Precondition Failed"
        case .payloadTooLarge: return "Payload Too Large"
        case .uriTooLong: return "Uri Too Long"
        case .unsupportedMediaType: return "Unsupported Media Type"
        case .rangeNotSatisfiable: return "Range Not Satisfiable"
        case .expectationFailed: return "Expectation Failed"
        case .imATeapot: return "Im A Teapot"
        case .misdirectedRequest: return "Misdirected Request"
        case .unprocessableEntity: return "Unprocessable Entity"
        case .locked: return "Locked"
        case .failedDependency: return "Failed Dependency"
        case .upgradeRequired: return "Upgrade Required"
        case .preconditionRequired: return "Precondition Required"
        case .tooManyRequests: return "Too Many Requests"
        case .requestHeaderFieldsTooLarge: return "Request Header Fields Too Large"
        case .unavailableForLegalReasons: return "Unavailable For Legal Reasons"
        case .internalServerError: return "Internal Server Error"
        case .notImplemented: return "Not Implemented"
        case .badGateway: return "Bad Gateway"
        case .serviceUnavailable: return "Service Unavailable"
        case .gatewayTimeout: return "Gateway Timeout"
        case .httpVersionNotSupported: return "Http Version Not Supported"
        case .variantAlsoNegotiates: return "Variant Also Negotiates"
        case .insufficientStorage: return "Insufficient Storage"
        case .loopDetected: return "Loop Detected"
        case .notExtended: return "Not Extended"
        case .networkAuthenticationRequired: return "Network Authentication Required"
        }
    }
}


extension HTTPStatusCodeError: LocalizedError {
  public var errorDescription: String? { "\(rawValue) \(text)" }
}
