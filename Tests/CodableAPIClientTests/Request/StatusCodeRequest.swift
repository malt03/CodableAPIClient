//
//  StatusCodeRequest.swift
//  CodableAPIClientTests
//
//  Created by Koji Murata on 2020/01/09.
//

import CodableAPIClient

struct StatusCodeRequest: CallCheckableAPIRequest {
    var callChecker = CallChecker<ResponseType>()

    var method: HTTPMethod { .get }
    var path: String { "/status/\(statusCode)" }
    
    let statusCode: Int
    
    var parameters = NoValue()
    typealias ResponseType = NoValue
}

struct NoValue: Codable, Equatable {}
