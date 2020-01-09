//
//  DeleteRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/07.
//

import CodableAPIClient

struct DeleteRequest: CallCheckableAPIRequest {
    var callChecker = CallChecker<Response, APIError<ErrorResponseType>>()

    var method: HTTPMethod { .delete }
    var path: String { "/delete" }
    
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
