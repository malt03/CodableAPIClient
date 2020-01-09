//
//  PostRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/07.
//

import CodableAPIClient

struct PostRequest: CallCheckableAPIRequest {
    var callChecker = CallChecker<Response, APIError<ErrorResponseType>>()
    
    var method: HTTPMethod { .post }
    var path: String { "/post" }
    
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
