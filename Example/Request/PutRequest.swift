//
//  PutRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/07.
//

import CodableAPIClient

struct PutRequest: APIRequest {
    var method: HTTPMethod { .put }
    var path: String { "/put" }
    
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
