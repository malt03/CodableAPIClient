//
//  GetRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/07.
//

import CodableAPIClient

struct GetRequest: APIRequest {
    var method: HTTPMethod { .get }
    var path: String { "/get" }
    
    var parameters: Parameters { Parameters(a: "foo", b: "bar") }
    
    typealias ResponseType = Response

    struct Parameters: Codable {
        let a: String
        let b: String
    }

    struct Response: Decodable {
        let json: Parameters
    }
}
