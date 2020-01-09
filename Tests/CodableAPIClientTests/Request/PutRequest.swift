//
//  PutRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/07.
//

import CodableAPIClient

struct PutRequest: CallCheckableAPIRequest {
    var callChecker = CallChecker<Response, APIError<ErrorResponseType>>()

    var method: HTTPMethod { .put }
    var path: String { "/put" }
    
    var parameters: Parameters
    
    typealias ResponseType = Response

    struct Parameters: Equatable, Codable {
        let a: String
        let b: String
    }

    struct Response: Equatable, Decodable {
        let json: Parameters
    }
}
